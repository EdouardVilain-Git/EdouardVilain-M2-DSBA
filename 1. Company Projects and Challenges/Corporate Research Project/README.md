# Corporate Research Project - Sensitive Pen for Dysgraphia Detection <a name="crp"></a>

<p align="center">
  <img src="../../images/CRI.jpg" alt="CRI" width="200"/>
</p>

- **Duration:** 6 months.
- **Group Size:** 5.
- **Project Description:** A research oriented project in collaboration with a CRI (Centre de Recherche Interdisciplinaire) PhD student. Her doctorate work focuses on dysgraphia and more specifically on building scalable tools for large scale detection. Dysgraphia, which is a deficiency in the ability to write, can be healed when diagnosed early. Thus, by analyzing handwriting data and building Machine Learning models, we aimed to **predict cases of dysgraphia in children**. Though I cannot unveil the work the PhD student is currently pursuing, the data we worked with corresponds to writing recordings from patients in the form of a variable size time series signal.
- **Final Result:** Data preprocessing was the crucial part of this project. Because the recordings were incredibly noisy, we extracted their statistical properties to produce a 1-dimensional feature set rather than building LSTMs. Based on this pre-processed data, we implemented two models:
  - A Decision Tree, with the intent of having highly interpretable results. 
  - A Deep Learning approach inspired from [How to Use Convolutional Neural Networks for Time Series Classification](https://towardsdatascience.com/how-to-use-convolutional-neural-networks-for-time-series-classification-56b1b0a07a57), with the intent of having enhanced results. 
  - **Results were unsatisfying** in practice (a RMSE of 5 for a score ranging from 0 to 40) but it was understood with our collaborator that **we lacked extensively in data.** Indeed, we worked with a dataset of under 40 patients, not enough to build a generalizable model, especially on such a complex task. In any case, **the PhD student and her supervisors were extremely pleased with the results**, which showed to be promising when data would be sufficient.

---

- **Files Description:**
    - **[Spectrogram Approach to Time Series Regression -](https://github.com/EdouardVilain-Git/EdouardVilain-M2-DSBA/blob/main/1.%20Company%20Projects%20and%20Challenges/Corporate%20Research%20Project/Spectrogram%20Prediction.pdf)** Some slides describing the convolutional approach to patient recordings. This describes how we converted time series into images (spectrograms), on which we could apply common convolutional Deep Learning techniques. We also evaluate the model on test patients.
