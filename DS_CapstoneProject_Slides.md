Data Science Capstone Project: Text Prediction
========================================================
author: S Nenning
date: 08 Jan 2019
autosize: true


Final project of "Data Science Specialization" course provided by Johns Hopkins University on Coursera. 
  
Development of Web Shiny Application for Text Prediction.


Overview
========================================================

  
- Objective of project is to develope an application to predict next word for one or more words entered by the user
- The prediction algorithm is build on a large corpus of twitter, news and blogs data
- Data has been loaded and analyzed to extract n-grams for algorithm.
- The applicaton is developed as a Web Shiny application.  


The "Text Prediction" application is available on <https://snenning.shinyapps.io/DS_Capstone_TextPrediction/>.  
For supporting documentation to the development go to <https://github.com/snenning/CDS_capstone_project>.


Data Exploratory Analysis and Text Mining
========================================================

Before developing the word prediction algorithm and web Shiny application, data is loaded, cleansed and analysed.
- A subset (sample) of the original data (blogs, twitter and news text) is loaded and merged into one corpus.
- A sequence of text cleaning steps are performed by removing URLs, HashTags, TwitterHandles, numbers, punctation, whitespaces and converting text to lower case.
- "tm" r-packages is used to create n-grams (unigram to 5-grams)
- The term count data frames are created from the n-grams and sorted according to the frequency
- These n-gram data frames are saved as comma separated files (.csv files), which are loaded when opening text prediction application.


Algorithm
========================================================

The developed data product has a user interface allowing to enter a sequence of words (sentence).
After text entry is submitted, the most likely next word options are displayed based on algorithm rules:  
- Last 4 words are used to predict next word using 5-gram directory; n-grams are loaded when application is opened.
- if no 5-gram found with matching first 4 words then last 3 words are used get next word from 4-gram directory.
- this logic continous retrieving last word from 3-gram and 2-gram for last 2 or last word respectively.
- if none found, then the message "No next word found" is displayed.
- User can select option to display 1 to 5 predicted next words based on its frequency in corpus.

Web Shiny Application interface
========================================================


![plot of chunk unnamed-chunk-1](./Shiny_TP_image.JPG)
