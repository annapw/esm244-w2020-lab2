#Attach packages

library(tidyverse)
library(shiny)
library(shinythemes)

#read in spooky df

library(readr)
spooky <- read_csv("data/spooky_data.csv")
View(spooky_data)

#Create a user interface

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Amazing"), #makes a title
   sidebarLayout(
  sidebarPanel("My widgets are here",
               selectInput(inputId = "state_select",
                           label = "Choose a color",
                           choices = unique(spooky$state)
                           )
               ), #names and creates a widget; find widget with google & use their code; inputs categorical options; re-names categories as necessary
  #alternative is choices = c("Crimson"= "red", "yellow", "orange")
  mainPanel("My outputs are here",
            tableOutput(outputId = "candy_table")
            ))  #makes a sidebar
)


server <- function(input, output) {

  state_candy <- reactive((
    spooky %>%
      filter(state== input$state_select) %>%
      select(candy, pounds_candy_sold)
  ))

  output$candy_table <- renderTable({
    state_candy() #normal parentheses calls it up as a reactive element
  }) # make an output to send back to the user interface
} # in first brackets is where we put the log for reactivity

#this is a shiny app; these are the two components:
shinyApp(ui = ui, server = server) #naming the user interface & server

#save this in a specific way, after which the "run app" button shows up

#add things on the ui that are non-reactive
#be super thoughtful about keeping track of parentheses



