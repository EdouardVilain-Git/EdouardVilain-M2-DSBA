# Edouard Vilain - M2 in Data Sciences & Business Analytics

## Introduction

This repo is a collection of the Data Science related projects of my final Master's year. It showcases works across Data Science related tasks (Querying, Engineering, Processing and Visualizing). 

The aim is to summarize the work I have achieved during this final Master's year and does not aim to be copied, except for personal use. By respect for the several third party authors involved in each of the projects, I have intentionally left project files aside, so code could not be run directly from the Git. Please contact me if you wish to work on a project in particular.

## Project Summaries

Here is a short summary of the projects showcased in this repo. For technical details or an in-depth look at the related code, please take a look at the related project file.

## I- Company Projects and Challenges

### 1. BCG Gamma Data Challenge - Predicting Parisian Road Traffic for Delivery Scheduling

- **Duration:** 1 week.
- **Project Description:** A Data Challenge organized by BCG Gamma on Parisian delivery scheduling. We were asked for two deliverables:
  - a predictive model for Parisian traffic density using public data.
  - a strategy to organize a delivery company's driver schedule according to our model's results.
- **Final Result:** We built a simple Catboost model with heavy feature engineering. Model performed extremely well when including environmental features such as weather, temperature and covid restrictions state. **Our group won the challenge** by providing the two best deliverables.

### 2. Eleven Strategy Hackathon - Worksite Monitoring

- **Duration:** 1 week.
- **Project Description:** A Hackathon organized by Eleven Strategy to ensure worksite safety by "utilizing Computer Vision technology". We were asked to develop a convolutional model to detect workers on worksites and use it to produce an on-site security protocol.
- **Final Result:** We used worksite annotated images to train Facebook's Detectron2. The model was transfer learned and produced extremely satisfying results in practice. We then created an API on Streamlit that would identify workers in real-time by processing on-site security camera images. Alerts would be sent when workers were detected in an unsual zone of the worksite. **Our group finished second** of the Hackathon.

### 3. Corporate Research Project - Sensitive Pen for Dysgraphia Detection

This is
