#' AMECO database
#'
#' Télécharge et renvoie le fichier complet d'AMECO pour le vintage demandé. Les vintages disponibles sont ceux sur le site de la Commission Eruopéen de 2011 à 2025, avec deux prévisions par an (printemps et automne) et une préivison à l'hiver 2015.
#' @param version (default 5/2025) version of AMECO (either 5/xxxx or spring xxxx for spring forecast or 11/xxxx autumn xxxx for autumn forecast)
#' @param reset (download even if cache is present)
#'
#' @returns a tibble withn AMECO
#' @export
#'
#' @examples

ameco <- function(version = "5/2025", reset = FALSE) {
  return(ameco_xx(version, reset)$data)
}

#' AMECO database codes
#'
#' Télécharge et renvoie le fichier des codes d'AMECO.
#' @param version (default 5/2025) version of AMECO (either 5/xxxx or spring xxxx for spring forecast or 11/xxxx autumn xxxx for autumn forecast)
#' @param reset (download even if cache is present)
#'
#' @returns a tibble withn AMECO codes
#' @export
#'
#' @examples

ameco_codes <- function(version = "5/2025", reset = FALSE) {
  return(ameco_xx(version, reset)$codes)
}

ameco_xx <- function(version = "5/2025", reset = FALSE) {
    version <- version_ameco(version)
    ameco_url <- url_ameco(version)

    freset <- !file.exists(".ameco/ameco_{version}.qs2" |> glue::glue()) |
      !file.exists(".ameco/ameco_countries_{version}.qs2" |> glue::glue()) |
      !file.exists(".ameco/ameco_codes_{version}.qs2" |> glue::glue())
    if (freset | reset) {
      dt <- download_ameco(url = ameco_url)
      qs2::qs_save(dt$data, file = ".ameco/ameco_{version}.qs2" |> glue::glue())
      qs2::qs_save(dt$codes, file = ".ameco/ameco_codes_{version}.qs2" |> glue::glue())
      qs2::qs_save(dt$countries, file = ".ameco/ameco_countries_{version}.qs2" |> glue::glue())
    } else {
      dt <- list()
      dt$data <- qs2::qs_read(".ameco/ameco_{version}.qs2" |> glue::glue())
      dt$codes <- qs2::qs_read(".ameco/ameco_codes_{version}.qs2" |> glue::glue())
      dt$countries <- qs2::qs_read(".ameco/ameco_countries_{version}.qs2" |> glue::glue())
    }
    return(dt)
  }
