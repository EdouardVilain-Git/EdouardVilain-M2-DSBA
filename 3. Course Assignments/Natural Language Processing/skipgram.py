from __future__ import division
import argparse
import pandas as pd
import spacy
import nltk
import os
import pickle

# useful stuff
import numpy as np
from scipy.special import expit
from sklearn.preprocessing import normalize

nlp = spacy.load("en_core_web_sm")

__authors__ = ['Benjamin Karaoglan','Louis de Comarmond','Ismail Khalil','Edouard Vilain']
__emails__  = ['benjamin.karaoglan@student-cs.fr','louis.de-comarmond@student-cs.fr','ismail.khalil@student-cs.fr','edouard.vilain@student-cs.fr']


def text2sentences(path):

    split_by_line_punc = [] #empty list where we append the sentence splitted by punctuation and lines.

    text = open(path).read()
    split_by_lines = text.splitlines() #splitline() split a string into a list (split based on line break) where each element of the list is a line.
    
    for line in split_by_lines:
        line_nlp = nlp(line) #apply the spacy model on each line to call the function sent later.
        sentences = [sentence for sentence in line_nlp.sents] #now append to a list sentences split also by punctuation .sents divide a text in sentences.
        split_by_line_punc.append(sentences)
    sentences = sum(split_by_line_punc, []) #remove the lists within the big list.

    words = []
    tokenized_sentences = []

    for sentence in sentences: #iterate through each sentence
        temp = [] #temporary list to stock tokenized sentence
        for element in sentence: #iterate through each word and punctuation
            if not (element.is_punct or element.is_space or element.is_stop): #remove punctuation, space and stopwords (to, you, the...)

                words.append(element.text.lower()) #append each word and lower it.
                temp.append(element.text.lower())
        tokenized_sentences.append(temp) #append tokenized word as a list in the big list of tokenized sentences.
        
    return tokenized_sentences


def loadPairs(path):
    data = pd.read_csv(path, delimiter='\t')
    pairs = zip(data['word1'],data['word2'],data['similarity'])
    return pairs

def init_corpus(sentences, minCount = 5):
    """
    Takes a list of tokenized sentences as input, runs through each word of the corpus, computes it's number of
    occurences and assigns it a unique ID.
    Then runs through the corpus a second time to apply sub-sampling and remove words which do not appear enough.
    """
    id_ = 0 # ID is a counter
    raw_word_occs = {} # Counts occurences
    
    # Run through each word of the corpus, compute word count
    for sentence in sentences:
        for word in sentence:
            # Increment occurences of corresponding word
            if word in raw_word_occs: raw_word_occs[word] += 1
            else: raw_word_occs[word] = 1
    
    ### Sub-Sampling and Filtering ###
    
    word_occs, w2id = {}, {} # Final word occurence count and ID count
    final_sentences = [] # Create new sentences rather than remove elements from initial list
    total_words = sum(raw_word_occs.values()) # Get total words in corpus
    
    for sentence in sentences:
        final_sentence = []
        for word in sentence:
            # If word appears less than minimum count remove it
            if raw_word_occs[word] >= minCount:
                # Assign ID if not already assigned
                if not word in w2id:
                    w2id[word] = id_
                    id_ += 1
                # Sub-Sample
                w_frac = raw_word_occs[word] / total_words # Count word fraction
                sample_prob = (np.sqrt(w_frac / .001) + 1) * .001 / w_frac # Compute sub-sampling probability
                # Pull random float between 0 and 1, if lower than sample_prob, keep word else remove
                if np.random.rand() <= sample_prob:
                    # Increment word count
                    if word in word_occs: word_occs[word] += 1
                    else: word_occs[word] = 1
                    final_sentence.append(word) # Append word to list
                    
        final_sentences.append(final_sentence) # Append cleansed sentence to final set of sentences
    
    return final_sentences, word_occs, w2id

def create_unigram(word_occs):
    """
    Creates Unigram Table with regards to 3/4 law.
    """
    unigram_table = []
    total_word_count = sum(word_occs.values())
    denominator = sum([np.power(value_,3/4) for value_ in word_occs.values()])
    for word in word_occs:
        word_appearances = int((np.power(word_occs[word],3/4) / denominator) * total_word_count)
        unigram_table += word_appearances * [word]
    return unigram_table


class SkipGram:
    def __init__(self, sentences, nEmbed=100, negativeRate=5, winSize = 5, minCount = 5):
        # Set base attribute values
        self.nEmbed = nEmbed
        self.negativeRate = negativeRate
        self.winSize = winSize
        self.minCount = minCount
        
        # Assign IDs and count occurences
        self.trainset, self.word_occs, self.w2id = init_corpus(sentences, minCount=minCount) # Dictionary of word occurences and IDs
        self.vocab = list(self.w2id.keys()) # list of valid words
        
        # Create Unigram Table
        self.unigram_table = create_unigram(self.word_occs)
        
        # Training parameters
        self.lr = 1e-3 # Learning Rate
        self.w1 = np.random.uniform(-1.,1.,(len(self.vocab),nEmbed)) # Weight matrices
        self.w2 = np.random.uniform(-1.,1.,(nEmbed,len(self.vocab)))
        self.trainWords = 0
        self.accLoss = 0
        self.loss = []

    def sample(self, omit):
        """samples negative words, ommitting those in set omit"""
        negativeIds = []
        while len(negativeIds) < self.negativeRate :
            word = np.random.choice(self.unigram_table)
            id_ = self.w2id[word]
            if (not id_ in omit) and (not id_ in negativeIds):
                negativeIds.append(id_)
        return negativeIds

    def train(self):
        for counter, sentence in enumerate(self.trainset):
            # sentence = filter(lambda word: word in self.vocab, sentence) # Take each sentence and remove words that aren't in the dictionary of valid words 

            for wpos, word in enumerate(sentence): # Run through each word of the sentence, wpos is the word's position
                wIdx = self.w2id[word]
                # Compute word's context window
                winsize = np.random.randint(self.winSize) + 1
                start = max(0, wpos - winsize)
                end = min(wpos + winsize + 1, len(sentence))

                for context_word in sentence[start:end]:
                    ctxtId = self.w2id[context_word]
                    if ctxtId == wIdx: continue # Skip the word itself
                    negativeIds = self.sample([wIdx, ctxtId])
                    self.trainWord(wIdx, ctxtId, negativeIds) 
                    self.trainWords += 1

            if counter % 1000 == 0 and counter >= 1:
                print(' > training %d of %d - Loss: %d' % (counter, len(self.trainset), self.accLoss))
                self.loss.append(self.accLoss / self.trainWords)
                self.trainWords = 0
                self.accLoss = 0.
    
    def forward_pass(self, hidden):
        """
        Takes as input vector of size (1,vocabulary_size) containing 0s and a 1 in the corresponding index.
        Passes through the model.
        """
        output = np.dot(hidden, self.w2) # (1,vocab_size)
        return output
    
    def backward_pass(self, hidden, output, wordId, ctxtId, negativeIds):
        """
        Computes backward pass to the network and updates matrice weights by gradient descent.
        """
        # Update input matrice weights
        grad_sum = (expit(output[0,ctxtId]) - 1) * np.squeeze(self.w2[:,ctxtId].T)
        for negativeId in negativeIds:
            grad_sum += expit(output[0,negativeId]) * np.squeeze(self.w2[:,negativeId].T)
        self.w1[wordId,:] = self.w1[wordId,:] - self.lr * grad_sum
        
        # Update output matrice weights
        self.w2[:,ctxtId] = self.w2[:,ctxtId] - self.lr * (expit(output[0,ctxtId]) - 1) * np.squeeze(hidden.T)
        for negativeId in negativeIds:
            self.w2[:,negativeId] = self.w2[:,negativeId] - self.lr * expit(output[0,negativeId]) * np.squeeze(hidden.T)
    
    def trainWord(self, wordId, contextId, negativeIds):
        """
        Apply Negative Sampling training step using context and negative sampled words.
        """
        # Compute hidden layer based on index of the word of interest
        hidden = self.w1[(wordId,),:]
        output = self.forward_pass(hidden) # Apply forward pass
        self.backward_pass(hidden, output, wordId, contextId, negativeIds) # Apply backward pass
        
        # Normalize rows of w1 and columns of w2
        self.w1, self.w2 = normalize(self.w1, axis=1), normalize(self.w2, axis=0)
        
        # Compute loss
        loss = -np.log(expit(output[0,contextId]))
        for negativeId in negativeIds:
            loss += -np.log(expit(-output[0,negativeId]))
        self.accLoss += loss
        
    def save(self,path):
        """
        Save model in a pickle file.
        """
        d = {
            "w1": self.w1,
            "w2": self.w2,
            "loss": self.loss,
            "w2id": self.w2id,
            "vocab": self.vocab,
        }
        pickle.dump(d, open(path,"wb"))

    def similarity(self,word1,word2):
        """
            computes similiarity between the two words. unknown words are mapped to one common vector
        :param word1:
        :param word2:
        :return: a float \in [0,1] indicating the similarity (the higher the more similar)
        """
        # Deal with words not in vocabulary
        if (word1 in self.w2id) and (word2 in self.w2id):
            # Compute Spearman Correlation
            id1, id2 = self.w2id[word1], self.w2id[word2]
            return np.dot(self.w1[id1,:],self.w1[id2,:]) # Rows of w1 are already normalized
        else:
            return 0

    @staticmethod
    def load(path):
        """
        Loads model from file.
        """
        file = open(path, "rb")
        d = pickle.load(file)
        
        skipgram = SkipGram([])
        skipgram.w1, skipgram.w2 = d["w1"], d["w2"]
        skipgram.loss = d["loss"]
        skipgram.w2id = d["w2id"]
        skipgram.vocab = d["vocab"]
        
        return skipgram

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument('--text', help='path containing training data', required=True)
    parser.add_argument('--model', help='path to store/read model (when training/testing)', required=True)
    parser.add_argument('--test', help='enters test mode', action='store_true')

    opts = parser.parse_args()

    if not opts.test:
        sentences = text2sentences(opts.text)
        sg = SkipGram(sentences)
        sg.train()
        sg.save(opts.model)

    else:
        pairs = loadPairs(opts.text)

        sg = SkipGram.load(opts.model)
        for a,b,_ in pairs:
            # make sure this does not raise any exception, even if a or b are not in sg.vocab
            print(sg.similarity(a,b))

