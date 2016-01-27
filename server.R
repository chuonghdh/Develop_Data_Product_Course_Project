require(shiny)
require(caret)
require(randomForest) #Random Forest Method
require(rpart)        #Decision Tree Method
require(gbm)          #Boosted trees Method
require(klaR)         #Support rda Method
require(e1071)        #Support rda Method

dataSet <<- NULL
trainData <<- NULL
testData <<- NULL
model <<- NULL
result <<- NULL

dataPreparation <- function(){
  # Load the data set
  data(iris)
  dataSet <<- iris
}

dataPartition <- function(dataPart){
  
  # Create training subset index based on 'dataPart' ratio
  inTrain <- createDataPartition(y = dataSet$Species, p = dataPart, list = FALSE)
  
  # Create training subset and testing subset
  trainData <<- dataSet[inTrain, ]
  testData <<- dataSet[-inTrain, ]
  
}

predictiveModeling <- function(trainingData, trainMethod, numFolder){
  
  # Define training control for K-Fold cross Validation with K = 'numFolder'
  fitControl = trainControl(method = "cv", number = numFolder)
  
  # Build a predictive model with method = 'trainMethod'
  predModel <- train(Species~., method=trainMethod, trControl = fitControl, data=trainingData)
  
  return(predModel)
}

testModel <- function(predModel, testingData) {
  
  # Apply model to testing subset
  predResult <- predict(predModel,testingData)
  
  # Display the predicting results
  confResult <- confusionMatrix(predResult, testingData$Species)
  
  return(confResult)
  
}

modelingApproach <- function(tm, nf, dp){
  txt <- paste(c("The Modeling Method is ", tm," with ", 
                 nf, "-fold Cross Validation applied on ", 
                 dp*100 ,"% of original dataset"),sep = '')
  return(txt)
}

shinyServer(
  function(input, output) {
    
    # Prepare statement for modeling approach
    approachStatement <- reactive({modelingApproach(input$iTrainMethod, input$iNumFolder, input$iDataPart)})
    output$oModelingApproach <- renderText({modelingApproach(input$iTrainMethod, input$iNumFolder, input$iDataPart)})
    
    # Read data & Prepare data
    dataPreparation()
    
    # Process
    output$oModelSummary <- renderPrint({
      # Partition Data
      dataPartition(input$iDataPart)
      
      # Modeling
      model <<- predictiveModeling(trainData,input$iTrainMethod, input$iNumFolder)
      
      # Print
      model$results
      
    })
    
    output$oPredResult <- renderPrint({
      input$iDataPart
      input$iTrainMethod
      input$iNumFolder
      
      # Test
      result <<- testModel(model, testData)
      
      # Print
      list(result$table, result$overall[1])
      
    })
    
  }
)

