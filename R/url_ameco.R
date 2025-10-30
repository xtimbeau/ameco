#' Renvoie l'url du vintage AMECO
#'
#' @param version (defaut "5/2025") 5/xxxx pour la version de printemps, 11/2025 pour laversion d'automne
#'
#' @returns string
#' @export
#'
#' @examples
#' url_ameco("5/2025")

url_ameco <- function(version = "52025") {
  ameco_url <- c(
    "52021"  = "https://economy-finance.ec.europa.eu/document/download/17372dca-211c-42b6-9a1d-89559b985d23_en?filename=ameco_spring2021.zip",
    "112021" = "https://ec.europa.eu/economy_finance/db_indicators/ameco/documents/ameco_autumn2021.zip",
    "52022" = "https://economy-finance.ec.europa.eu/document/download/c5be576e-fbea-45f3-98a5-3cf59d16d70a_en?filename=ameco_spring2022.zip",
    "112022" = "https://economy-finance.ec.europa.eu/document/download/b16e473a-04ef-4ec8-b2f8-1e0c30a39d3c_en?filename=ameco_autumn2022.zip",
    "52023" = "https://economy-finance.ec.europa.eu/document/download/adbcba6f-8169-4d6d-80e7-7a365ff6e87d_en?filename=ameco_spring2023.zip",
    "112023" = "https://economy-finance.ec.europa.eu/document/download/6a48b097-bd09-496b-908f-404d0e85cff8_en?filename=AMECO_2023_Autumn_Revised.zip",
    "52024" = "https://economy-finance.ec.europa.eu/document/download/ad8d7bd0-c4d9-4860-b597-bb613408d6bd_en?filename=AMECO_2024_Spring_final.zip",
    "112024" = "https://economy-finance.ec.europa.eu/document/download/9c2630c3-6c25-456d-b484-6b05c202e8ce_en?filename=ameco0.zip",
    "52025" = "https://ec.europa.eu/economy_finance/db_indicators/ameco/documents/ameco0.zip"
  )
  return(ameco_url[[version]])
}
