---
title   : 'DDP Course Project: Shiny Application and Reproducible Pitch'
subtitle: 'Evaluate different classification methods to predict iris flower species'
author  : "Chuong Hoang"
date    : "January 25, 2016"

framework: io2012
highlighter: highlight.js
hitheme : tomorrow
mode    : selfcontained
output  : html_presentation

---

## Introduction

This is an R Markdown presentation to demonstrate the purpose of the shiny application within the framework of <b>Develop Data Product</b> Course. 

The application is for applying different classification methods to <b>iris</b> dataset. the trained models will  run on testing dataset for result (accuracy) evaluation.  

The application receives 3 input parameters are:

1. Training Method
2. Partition for Training Dataset
3. Number of Folder for Cross Validation

And reactive outputs displayed as a result of server calculations are:

1. Modeling Approach
2. Model Summary
3. Predict Results

---

## Application Interface Overview (ui.R)

The application ui includes 2 areas: <b>Side bar pannel</b> - contain input parameters; <b>Main pannel</b> - contain descriptions and results

   |Side bar pannel    |Main pannel
---|-------------------|-----------------------
   | <b>Training Method</b> - a radio button selector with 4 classification methods: Recursive partitioning, Boosted trees, Random forests, Regularized Discriminant Analysis. | <b>Introduction</b> - giving background understanding of the application
   | <b>Partition for Training Dataset</b> - a numeric input defines how many percent observation in original dataset to be kept for building model. | <b>Modeling Approach</b> - provide the reactive output statement demonstrate the approach of training model.
   | <b>Number of Folder for Cross Validation</b> - a numeric input defines how many folders to be partitioned for Cross Validation | <b>Model Summary</b> - provide the summary of the training model after be built
   | - | <b>Predict Results</b> - provide the results in Reference Matrix and Accuracy Rate

---

## Server Process Overview (server.R)

The server.R initializes and maintains 4 global variables:


```r
dataSet <<- NULL   # a data object store original dataset
trainData <<- NULL # a data object store training dataset after partition
testData <<- NULL  # a data object store testing dataset after partition
model <<- NULL     # a model object store returned model after training
result <<- NULL    # a confusion matrix object store testing results
```

And 5 functions with following feature descriptions:


```r
dataPreparation()                                     # load 'iris' dataset to 'dataSet' object
modelingApproach(trainMethod, numFolder, dataPart)    # return Modeling Approach Statement
dataPartition(dataPart)                               # partition original dataset
predictiveModeling(trainData, trainMethod, numFolder) # build up a predictive model
testModel(predModel, testData)                        # apply built model to testData set
```

---

## Result Discussion

Different methods will bring different accuracy rates and request different time costs. To demonstrate the result we fix 2 input parameters with default value:

* Partition for Training Dataset = .75
* Number of Folder for CV = 5

<p style="font-size:60%; color:blue;"> Note: due to course project requirement #4, the executable embedded R code is located here. Evaluator can check "Reproducible Pitch Presentation.Rmd" file for more detail </p>





```
##   methodList processTime accuracy
## 1      rpart        0.69     91.7
## 2        gbm        1.16     88.9
## 3         rf        1.14     94.4
## 4        rda       19.41     94.4
```

Within 4 used methods, the Random Forest method only cost 1.25 seconds but give the highest accuracy is 94.4%

