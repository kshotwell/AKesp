
# these spreadsheets were created with an R package, unfortunately it wasn't saved in the script though

fxn_nodes <- read.csv(here::here("data-raw/nodes.csv"))

fxn_edges <- read.csv(here::here("data-raw/edges.csv"))

visNetwork::visNetwork(nodes = fxn_nodes,
                       edges = fxn_edges)
