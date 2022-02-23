# load package
devtools::load_all()

# create a template in a new folder
AKesp::create_template(path = "../test")

# after AKesp is a proper package, should be able to use this instead:
# create_template(path = here::here())

# turn the template into an esp
AKesp::render_esp(dir = "../test",
                  ref_spreadsheet = "../test/references_spreadsheet.csv",
                  tab_spreadsheet = "../../test/table_spreadsheet.csv",
                  fig_spreadsheet = "../../test/figure_spreadsheet.csv")

# after AKesp is a proper package, should be able to use this instead:
# AKesp::render_esp(dir = here::here(),
#                   ref_spreadsheet = here::here("references_spreadsheet.csv"),
#                   tab_spreadsheet = here::here("table_spreadsheet.csv"),
#                   fig_spreadsheet = here::here("figure_spreadsheet.csv"))

devtools::load_all()
AKesp::render_esp(dir = "../test",
                  ref_spreadsheet = "../test/references_spreadsheet.csv",
                  tab_spreadsheet = "../../test/table_spreadsheet.csv",
                  fig_spreadsheet = "../../test/figure_spreadsheet.csv",
                  esp_type = "report card",
                  esp_text = "report-card-esp-text-template.docx",
                  esp_data = AKesp::bbrkc_long)
