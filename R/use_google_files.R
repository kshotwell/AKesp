#' Use files from Google Drive
#'
#' This function downloads files from Google Drive to a temporary directory to use when rendering an ESP. Intended for internal use by `render_esp`.
#' @param url The URL of the Google folder with the files
#' @param ... passed to `googledrive::drive_download` (ex, `overwrite = TRUE`)
#' @export

use_google_files <- function(url, ...){
  message("getting google files...")
  files <- googledrive::drive_ls(path = googledrive::as_id(url), recursive = TRUE)

  message("your files:")
  print(files)

  dir <- paste(tempdir(), "temp_esp", sep = "/")
  dir.create(dir)

  for(i in 1:nrow(files)) {
    googledrive::drive_download(file = googledrive::as_id(files$id[i]),
                                path = paste(dir, files$name[i], sep = "/"),
                                ...) %>%
      try() %>% # folders can't be downloaded
      invisible()
  }
  dir <- dir %>%
    stringr::str_replace_all("\\\\", "/")
  message(paste("your files are in:", dir))
  return(dir)
}
