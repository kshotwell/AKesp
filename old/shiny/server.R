server <- function(input, output, session) {
  `%>%` <- magrittr::`%>%`

  observeEvent(input$go, {
    data <- AKesp::get_esp_data(input$stock)

    height <- length(unique(data$INDICATOR_NAME)) * 200

    output$traffic <- renderPlot(AKesp::esp_traffic(data = data,
                                              name = input$stock),
                                 height = height)

    output$table <- renderUI(AKesp::esp_traffic_tab(data = data,
                                                         year = c(2017:2021)) %>%
                               flextable::htmltools_value()
                             )
  })
}
