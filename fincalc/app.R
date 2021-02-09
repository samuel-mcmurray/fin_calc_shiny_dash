# app.R
library(shiny)
library(shinydashboard)



# ui part

header <- dashboardHeader(title = 'Financial Calculator')

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem('Dashboard', tabName = 'dashboard', icon = icon('dashboard')),
        menuItem('Simple Compounding',tabName = 'simple_compound', icon = icon('calculator'))
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = 'dashboard',
            fluidRow(
                box(
                    title = 'Overview',
                    sliderInput('user_rating', 'How do you rate this dashboard?', 1, 10, 10)
                )
            )
        ),
        tabItem(tabName = 'simple_compound',
            fluidRow(
                box(
                    title = 'Simple Compounding Calculator',
                    numericInput('principle', 'Principle', 10000, min = 0, step = 1000),
                    numericInput('rate', 'Rate (decimal)', 0.01, min = -1, step = 0.01),
                    numericInput('periods', 'Num. Periods', 20, min = 0),
                    actionButton('compute', 'Calculate Return')
                ),
                box(
                    title = 'Final Amount',
                    textOutput('final')
                )
            )
        )
        
    )
)

ui = dashboardPage(header, sidebar, body)



# server part

server <- function(input, output) {
    
   simple_comp_input = eventReactive(input$compute, {
        c(input$principle, input$rate, input$periods)
    })
    output$final = renderPrint({
        print(sprintf('$%s', round(simple_comp_input()[1]*(1+simple_comp_input()[2])**simple_comp_input()[3],2)))
    })
}



# Run the application 
shinyApp(ui = ui, server = server)
