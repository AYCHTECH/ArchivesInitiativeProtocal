# library(httr)

oai_api <- function(
  base_url,
  verb = c("Identify", "GetRecord", "ListIdentifiers", "ListMetadataFormats",
           "ListRecords", "ListSets"),
  ...,
  content_as="parsed") {

  # Process arguments
  valid_args <- c("identifier", "metadataPrefix", "from", "until", "set", "resumptionToken")
  arg <- list(...)
  arg_ok <- names(arg) %in% valid_args
  if( !all(arg_ok) )
    stop("invalid arguments: ", paste( names(arg)[!arg_ok], collapse=", " ) )
  query_args <- c( list(verb=verb), arg )

  # Make the request
  url <- modify_url(base_url, query=query_args)
  resp <- GET(url)

  # TODO Check for http errors
  # TODO Check for oai-pmh errors

  # Parsed
  parsed <- content(resp, as=content_as)

  # TODO Check for parsing errors

  structure(
    list(
      base_url = base_url,
      content = parsed,
      response = resp
    ),
    class = "oai_api"
  )
}

print.oai_api <- function(x, ...) {
  cat("<OAI ", x$response$url, ">\n", sep="")
  str(x$content)
  invisible(x)
}


if(FALSE) {
  burl <- "http://export.arxiv.org/oai2"
  res <- oai_api(burl, verb="Identify")
  xml <- content(resp)
  xml_structure(xml)
  # z <- oai::id("http://export.arxiv.org/oai2")
}
