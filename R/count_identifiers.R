#' Count OAI-PMH identifiers for a data provider.
#'
#' @export
#' @param url OAI-PMH base url
#' @param prefix Specifies the metadata format that the records will be
#'     returned in.
#' @param ... Curl options passed on to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' count_identifiers()
#' count_identifiers(c(
#'  "http://oai.datacite.org/oai",
#'  "http://archivesic.ccsd.cnrs.fr/oai/oai.php",
#'  "http://www.hindawi.com/oai-pmh/oai.aspx"
#' ))
#'
#' # curl options
#' library("httr")
#' count_identifiers(config = verbose())
#' }
count_identifiers <- function(url = "http://oai.datacite.org/oai", prefix = 'oai_dc', ...) {
  check_url(url)
  args <- sc(list(verb = 'ListIdentifiers', metadataPrefix = prefix))
  rbind_fill(lapply(url, ci, args = args, ...))
}

ci <- function(x, args, ...) {
  res <- GET(x, query = args, ...)
  xml <- xml2::read_xml(content(res, "text"))
  children <- xml_children(xml_children(xml))
  count <- as.numeric(
    xml_attr(
      children[sapply(children, xml_name) == "resumptionToken"],
      "completeListSize"
    )
  )
  data.frame(url = x, count = count, stringsAsFactors = FALSE)
}