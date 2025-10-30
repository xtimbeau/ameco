download_ameco <- function(url) {
  dir.create(".ameco")
  curl::curl_download(url, destfile = "./.ameco/ameco.zip", quiet = TRUE)
  ameco <- unzip(".ameco/ameco.zip", exdir = "./.ameco/tmp")
  if(file.exists(".ameco/tmp/ameco0.zip"))
    ameco <- unzip(".ameco/tmp/ameco0.zip", exdir = ".ameco/tmp")
  dt <- purrr::map_dfr(ameco, ~ {
    ff <- try(
      suppressMessages(
        vroom::vroom(.x, delim=";", progress = FALSE, show_col_types = FALSE)))
    if ("try-error" %in% class(ff)) {
      cli::cli_alert_warning("Erreur en lisant {.x} de ameco")
      ff <- tibble::tibble()
    }
    ff
  })
  out_cols <- names(dt)[stringr::str_detect(names(dt), "^\\.\\.\\.[:digit:]+")]
  file.remove(".ameco/ameco.zip")
  unlink(".ameco/tmp", recursive = TRUE)
  dt <- dt |>
    dplyr::select(-any_of(out_cols)) |>
    tidyr::separate_wider_delim(CODE, delim = ".", names = c("geo", "c1", "c2", "unit_code", "c4", "code"))
  dt <- dt |>
    tidyr::pivot_longer(cols = dplyr::matches("[0-9]{4}"), names_to = "year", values_to = "value") |>
    dplyr::rename(country =COUNTRY,
                  subchapter = `SUB-CHAPTER`,
                  title = TITLE,
                  unit = UNIT) |>
    dplyr::mutate(time = lubridate::ymd(year, truncated=2),
                  across(c(year, c1, unit_code, c2, c4), as.integer),
                  across(c(geo, code, country, subchapter, title, unit), factor )) |>
    tidyr::drop_na(value) |>
    dplyr::group_by(geo) |>
    dplyr::mutate(is.prev = year >= max(year) - 1) |>
    dplyr::ungroup()
  meta <- list(
    countries = dt |> dplyr::distinct(geo, country),
    codes = dt |>
      dplyr::group_by(code, c1, c2, unit_code, c4, subchapter, title) |>
      dplyr::summarize(unit = list(unique(unit)), countries = list(unique(geo)))
  )
  dt <- dt |>
    dplyr::select(-c(country, subchapter, title, unit))

  return(list(data = dt, codes = meta$codes, countries = meta$countries))
}
