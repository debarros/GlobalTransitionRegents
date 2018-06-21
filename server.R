library(shiny)

source("functions.R")

shinyServer(function(input, output) {
  
  # This determines when to call the function that processes the data
  OutFile = reactive ({
    if(is.null(input$inFile)){                      # If nothing has been uploaded,
      ret = NULL                                    # don't do anything yet.
    } else {                                        # If something has been uploaded,
      ret = AddItemResponses(input$inFile$datapath) # call the function that processes the data.
    } # /if-else
    return(ret)
  }) # /reactive
  
  
  # This creates the file to be downloaded
  output$globaltransition.csv <- downloadHandler(
    filename = "globaltransition.csv",
    content = function(file) { write.csv(OutFile(), file) } # Outfile has () after it b/c it's a reactive object
  ) # /downloadHandler
  
  
  # This creates the download button
  output$downloadFile <- renderUI({
    if (is.null(OutFile())){                     # If the output hasn't been created yet,
      ret = NULL                                 # do nothing.
    } else  {                                    # If the output has been created,
      ret = downloadButton(                      # create a download button that links to file that will be downloaded.
        outputId = "globaltransition.csv",       
        label = "Download the reformatted data")
    } # /if-else
    return(ret)
  }) # /renderUI
  
}) # /shinyServer
