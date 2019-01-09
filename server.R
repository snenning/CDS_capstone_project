#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
##### loading packages and saved n-grams #####

suppressWarnings(library(stringr))
suppressWarnings(library(data.table))
suppressWarnings(library(shiny))


# Load n-gram to Data frame files
 #   source("load_RDS.R")
df_bigram_DTM <- read.csv("ngram2.csv")
df_trigram_DTM <- read.csv("ngram3.csv")
df_fourgram_DTM <- read.csv("ngram4.csv")
df_fivegram_DTM <- read.csv("ngram5.csv")

    match <- "";
    

##### functions used in code #####
    
# function to count number of words
    f_count_word <- function(x) { sum(str_count(x, "\\S+")) } # already defined above

# function to get next words with 3 highest frequencies
    f_response <- function(dt_ngram,chr_input, c_words, n_words){
      l_input1 <- grepl(x =dt_ngram$word, pattern = chr_input)
      sum(l_input1)
      
      dt_res_ngram <- dt_ngram[(l_input1==TRUE),]
      g <- gregexpr( pattern = chr_input, dt_res_ngram$word)
      l_input2 <- unlist(g)==1
      
      sum(l_input2)
      dt_res_ngram <- head(dt_res_ngram[(l_input2==TRUE),],n_words)
      
      if (c_words == 1L)
      {response <- substr(dt_res_ngram$word, str_length(chr_input) + 1L, str_length(dt_res_ngram$word))} else
      {response <- substr(dt_res_ngram$word, str_length(chr_input) + 1L, str_length(dt_res_ngram$word))}
    }

# function to split input sentence in separate words
    f_vchr_input_words <- function(chr_input) {
      if (length(chr_input) != "") {
        strsplit(chr_input,"\\ ")
        }
    }

#use function to get word count for texts
    f_count_word <- function(list_text) { sum(str_count(list_text, "\\S+")) }
    
    
    

##### Define server logic required to draw a histogram #####
    
shinyServer(function(input, output) {
  output$txt_output4 <- renderText("is completed");  #displays when data load is completed
  output$txt_output1 <- renderText({input$txt_input})  # displays input sentence on main panel
  
  
  prediction <-  reactive({
    
    # getting input text sentence and conversions    
     chr_input <- as.character(input$txt_input)
     chr_input <- as.character(chr_input)
     chr_input <- tolower(chr_input)
 
    # various variables
    vchr_input_words <- f_vchr_input_words(chr_input)
    c_w_chr_input <- f_count_word(chr_input)
    c_words <- c_w_chr_input
    n_words <- input$n_words
    
   # chr_input <- paste0(chr_input," ") # adding a space to end of word to avoid search of word in mid word of n-gram

        
    # if input sentence has more than 4 words then select last 4 words for search
        if (c_w_chr_input > 4L)  {    # start if condition3
          c_words <- 4L
          chr_input <- ""
          for (i in (c_w_chr_input-(c_words-1L)):c_w_chr_input){
            if (i==(c_w_chr_input-(c_words-1L)))
            {chr_input <- vchr_input_words[[1]][i]} else 
            {chr_input <- paste(chr_input,vchr_input_words[[1]][i])}
          } 
        }  #end if condiion3 
        
        l_chr_input <- nchar(chr_input)
        match <- NULL
  
  
  # loop will stop when break condition is fulfilled 
      repeat {             
        if (c_words == 4L) {
          dt_ngram <- setDT(df_fivegram_DTM)
          chr_input <- paste0(chr_input," ") # adding a space to end of word to avoid search of word in mid word of ngram
          match <- f_response(dt_ngram, chr_input, c_words, n_words)
          match
        }
        if (length(match) == 0L & c_words==3){    
          dt_ngram <- setDT(df_fourgram_DTM)
          chr_input <- paste0(chr_input," ") # adding a space to end of word to avoid search of word in mid word of ngram
          match <- f_response(dt_ngram, chr_input, c_words, n_words)
          match
        }
        if (length(match) == 0L & c_words==2){
          dt_ngram <- setDT(df_trigram_DTM)
          chr_input <- paste0(chr_input," ") # adding a space to end of word to avoid search of word in mid word of ngram
          match <- f_response(dt_ngram, chr_input, c_words, n_words)
          match
        }
        if (length(match) == 0L & c_words==1){
          dt_ngram <- setDT(df_bigram_DTM)
          chr_input <- paste0(chr_input," ") # adding a space to end of word to avoid search of word in mid word of ngram
          match <- f_response(dt_ngram, chr_input, c_words, n_words)
          match
        }
        
        # if no match then remove first word of input sentence and search again
        if (length(match) == 0L)  {    # start if condition2
          c_words <- c_words - 1L
          chr_input <- ""
          for (i in (c_w_chr_input-(c_words-1L)):c_w_chr_input){
            if (i==(c_w_chr_input-(c_words-1L)))
            {chr_input <- vchr_input_words[[1]][i]}
            else 
            {chr_input <- paste(chr_input,vchr_input_words[[1]][i])}
          } 
        }  #end if condiion2 
        
        # start if conditon1 (repeat loop break condition)
        if  (length(match)!=0L) {  # loop will break (stop) if  match found (next word)
        #  print("next word found") 
          print(match)
          break
        }  
        else if (c_words==0) {  # or loop will break (stop) if  word count of string is null
          print("No next word found") 
          break
        } #end if condition 1 word count
        
      }  # end repeat loop;
        
        if (length(match) == 0L) {match <- "No next word found"}
         
    })

  
      output$txt_output2 <- renderPrint({
        result <- prediction()
        })
      
      
})
