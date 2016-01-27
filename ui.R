shinyUI(pageWithSidebar(
  headerPanel("Predictive Application"),
  sidebarPanel(
    p(span('Input Parameters', style="font-size: 19pt")),
    radioButtons("iTrainMethod", "Training Method",
                 choices = c("Recursive partitioning" = "rpart",
                             "Boosted trees" = "gbm",
                             "Random forests" = "rf",
                             "Regularized Discriminant Analysis" = "rda"
                             ),
                 selected = "rpart"
                 ),
    numericInput('iDataPart', 'Data Partition for Training dataset', 0.75, min = 0.50, max = 0.95, step = 0.05),
    numericInput('iNumFolder', 'Number of Folder for CV', 5, min = 1, max = 20, step = 1),
    submitButton('Modeling')
  ),
  mainPanel(
    h2("Modeling and Results"),
    h3('Introduction'),
    p('This application is based on default', strong('iris sample dataset'),
      ', The purpose of this work is to build a classification machine learning application
      helping to apply different training methods to predict the ', 
      em('Species'),' of each observation in testing dataset'),
    h3('Modeling Approach'),
    textOutput("oModelingApproach"),
    h3('Model Summary'),
    verbatimTextOutput("oModelSummary"),
    h3('Predict Results'),
    verbatimTextOutput("oPredResult")
  )
))