version_ameco <- function(version = "5/2025") {
  version <- version |>
    stringr::str_trim() |>
    stringr::str_remove_all(" ")
  if(stringr::str_detect(version, "[5|11]/[:digit:]{4}")|version=="2/2015")
    return(stringr::str_remove(version, "/"))
  if(stringr::str_detect(version, "[5|11][:digit:]{4}")|version=="22015")
    return(version)
  if(stringr::str_detect(version, "[spring|autumn][:digit:]{4}")|version=="winter 2015") {
    version <- version |>
      stringr::str_replace("spring", "5") |>
      stringr::str_replace("autumn", "11") |>
      stringr::str_replace("winter", "2")
    return(version)
  }
  cli::cli_alert_warning("Version inconnue, dernière version utilisée")
  return("52025")
}
