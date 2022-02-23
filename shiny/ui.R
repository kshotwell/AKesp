ui <- fluidPage(h1("Test Alaska ESP shiny app"),
                selectInput(inputId = "stock",
                            label = "Which stock?",
                            choices = AKesp::esp_stock_options()),
                actionButton(inputId = "go",
                             label = "submit"),

                uiOutput(outputId = "table"),
                plotOutput(outputId = "traffic")
                )
