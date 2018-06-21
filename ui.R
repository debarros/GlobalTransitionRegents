library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Extract Item Response Information from the Pearson data file for the Transition Regents Exam in Global History Exam"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("inFile", "Upload xlsx file from Pearson"), # input$inFile holds the information about the uploaded file, but not the actual file
      uiOutput('downloadFile')                              # downloadFile is the name of the widget, not the download object
    ), # /sidebarPanel
    mainPanel(
      h3("The process is as follows:"),
      tags$ol(
        tags$li("Get the .xlsx file from Pearson."),
        tags$li("Upload it using the button on the right"),
        tags$li("After you upload it, a download button will appear.  Click it.")
      ),
      h3("Some things to note:"),
      tags$ul(
        tags$li(paste0("The data file from Pearson appears to use 3 characters for each DBQ item in Part 3A.  ",
                       "It appears that the first two characters are always 0, and the third holds the actual score.  ",
                       "If that turns out not to be the case, the results you get may be wrong.")),
        tags$li("Questions?  Comments?  Email ", tags$a(href="mailto:pdebarros@greentechhigh.org","pdebarros@greentechhigh.org"),"."),
        tags$li("Want the source code? ", tags$a(href="mailto:pdebarros@greentechhigh.org","Click here"),".")
      )
      
    ) # /mainPanel
  ) # /sidebarLayout
)) # /shinyUI
