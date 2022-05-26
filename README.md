# Edouard Vilain - M2 in Data Sciences & Business Analytics

## Introduction

This repo is a collection of the Data Science related projects of my final Master's year. It showcases works across Machine Learning and Data Science related tasks (Querying, Engineering, Processing and Visualizing). 

The aim is to summarize the work I have achieved during this final Master's year and does not aim to be copied, except for personal use. By respect for the several third party authors involved in each of the projects, I have intentionally left project files aside, so code could not be run directly from the Git. Please contact me if you wish to work on a project in particular.

## Project Summaries

Here is a short summary of the projects showcased in this repo. For technical details or an in-depth look at the related code, please take a look at the related project file.

## I- Company Projects and Challenges

### 1. BCG Gamma Data Challenge - Predicting Parisian Road Traffic for Delivery Scheduling

- **Duration:** 1 week.
- **Project Description:** A Data Challenge organized by BCG Gamma on Parisian delivery scheduling. We were asked for two deliverables:
  - a predictive model for Parisian traffic density using public data.
  - a strategy to organize a delivery company's driver schedule according to our model's results.
- **Final Result:** We built a simple Catboost model with heavy feature engineering. Model performed extremely well when including environmental features such as weather, temperature and covid restrictions state. Our group **won the challenge** by providing the two best deliverables.

### 2. Eleven Strategy Hackathon - Worksite Monitoring

- **Duration:** 1 week.
- **Project Description:** A Hackathon organized by Eleven Strategy to ensure worksite safety by "utilizing Computer Vision technology". We were asked to develop a convolutional model to detect workers on worksites and use it to produce an on-site security protocol.
- **Final Result:** We used worksite annotated images to train Facebook's Detectron2. The model was transfer learned and produced extremely satisfying results in practice. We then created an API on Streamlit that would identify workers in real-time by processing on-site security camera images. Alerts would be sent when workers were detected in an unsual zone of the worksite. Our group **finished second** of the Hackathon.

### 3. Corporate Research Project - Sensitive Pen for Dysgraphia Detection

- **Duration:** 6 months.
- **Project Description:** A research oriented project in collaboration with a CRI (Centre de Recherche Interdisciplinaire) PhD student. Her doctorate work focuses on dysgraphia and more specifically on building scalable tools for large scale detection. Dysgraphia, which is a deficiency in the ability to write, can be healed when diagnosed early. Thus, by analyzing handwriting data and building Machine Learning models, we aimed to predict cases of dysgraphia in children. Though I cannot unveil the work the PhD student is currently pursuing, the data we worked with corresponds to writing recordings from patients in the form of a variable size time series signal.
- **Final Result:** Preprocessing of data was the crucial part of this project. Because the recordings were incredibly noisy, we extracted their statistical properties to produce a 1-dimensional feature set rather than building LSTMs. Based on this pre-processed data, we implemented two models:
  - A Decision Tree, with the intent of having highly interpretable results. 
  - A Deep Learning approach inspired from [How to Use Convolutional Neural Networks for Time Series Classification](https://towardsdatascience.com/how-to-use-convolutional-neural-networks-for-time-series-classification-56b1b0a07a57), with the intent of having enhanced results. 
  - **Results** were practically unsatisfying (an RMSE of 5 for a score ranging from 0 to 40) but it was understood with our collaborator that **we lacked extensively in data.** Indeed, we worked with a dataset of under 40 patients, not enough to build a generalizable model, especially on such a complex task. In any case, **the PhD student and her supervisors were extremely pleased with the results**, which showed to be promising when data would be sufficient. 


## II- Course Final Projects

### 1. MLNS

### 2. Fundamentals of Deep Learning

### 3. NLP

### 4. Advanced Optimization

### 5. Marketing Analytics

### 6. Geometric Methods


## III- Theoretical Assignments

### 1. Advanced Machine Learning

### 2. Advanced Statistics

### 3. Advanced Deep Learning

### 4. Ensemble Learning

### 5. NLP
