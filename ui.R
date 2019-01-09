#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data Science Capstone Project - Text Prediction"),
  h5("This application predicts the next word based on the sentence entered by user, who has the option to display 1 to 5 predicted words."),
  h5("Type your sentence and press 'Enter' button or click 'Submit' to execute prediction algorithm."),
  h5("Note: When opening the application, the text corpus used for text prediction is loaded which takes appr 15secs."),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("txt_input", "Enter your sentence below and press 'Enter' or click 'Submit'", value = "type sentence"),
      br(),
       sliderInput("n_words",
                   "Select number of predicted 'next' words, and click 'Submit'",
                   min = 1,
                   max = 5,
                   value = 3),
    br(),
     submitButton("Submit")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      h6("Text Corpus loading"),
      verbatimTextOutput("txt_output4", placeholder = TRUE),
      br(),
      h4("Sentence Input:"),
      verbatimTextOutput("txt_output1"),
      br(),
      h4("Predicted Next Words are:"),
      verbatimTextOutput("txt_output2")
      
    )
  )
))
