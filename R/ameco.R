#' AMECO database
#'
#' @param version (default 5/2025) version of AMECO (either 5/xxxx for spring forecast or 11/xxxx for autumn forecast)
#' @param reset (download even if cache is present)
#'
#' @returns a tibble withn AMECO
#' @export
#'
#' @examples
#' ameco()

ameco <- function(version = "5/2025", reset = FALSE) {

  ameco_url <- url_ameco(version)
  if(is.null(ameco_url)) {
    cli::cli_alert_warning("{version} n'est une version connue d'AMECO")
    return(NULL)
  }
  vv <- stringr::str_remove(version, "/")
  freset <- !file.exists(".ameco/ameco_{vv}.qs2" |> glue::glue())
  if (freset | reset) {
    dt <- download_ameco(url = ameco_url)
    qs2::qs_save(dt, file = ".ameco/ameco_{vv}.qs2" |> glue::glue())
  } else {
    dt <- qs2::qs_read(".ameco/ameco_{vv}.qs2" |> glue::glue())
  }
  return(dt)
}
