% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count_identifiers.R
\name{count_identifiers}
\alias{count_identifiers}
\title{Count OAI-PMH identifiers for a data provider.}
\usage{
count_identifiers(url = "http://export.arxiv.org/oai2",
  prefix = "oai_dc", ...)
}
\arguments{
\item{url}{(character) OAI-PMH base url. Defaults to the URL for
arXiv's OAI-PMH server (http://export.arxiv.org/oai2)
or GBIF's OAI-PMH server (http://api.gbif.org/v1/oai-pmh/registry)}

\item{prefix}{Specifies the metadata format that the records will be
returned in}

\item{...}{Curl options passed on to \code{\link[httr]{GET}}}
}
\description{
Count OAI-PMH identifiers for a data provider.
}
\details{
Note that some OAI providers do not include the entry
\code{completeListSize}
(\url{http://www.openarchives.org/OAI/openarchivesprotocol.html#FlowControl})
in which case we return an NA - which does not mean 0, but rather we don't
know.
}
\examples{
\dontrun{
count_identifiers()

# curl options
# library("httr")
# count_identifiers(config = verbose())
}
}
