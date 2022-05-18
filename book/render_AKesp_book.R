

# have to change working directory for bookdown
setwd(here::here("book"))
bookdown::render_book(input = ".",
                      config_file = "_bookdown.yml"
)

# change back to root project directory
setwd(here::here())
