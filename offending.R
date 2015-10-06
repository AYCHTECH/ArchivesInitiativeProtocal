



l <- readLines("offending.txt")
txt <- paste(l, collapse="\n")
html <- xml2::read_html(txt)
class(html)
xml <- xml2::read_xml(txt)
xml <- read_xml_safely(txt)
records <- xml2::xml_find_all(html, "//record")
records_txt <- lapply(records, as.character)
grep( intToUtf8(7), l )
x <- l[grep( intToUtf8(25), l )]
xml2::read_xml(x)
xml2::xml_find_all( xml2::read_html(x), "//datestamp")

res <- lapply(records_txt, function(x) try(xml2::read_xml(x)))
sapply(res, class)
res <- lapply(l, function(x) try(xml2::read_xml(x)))
xml2::read_xml("<camelCase/>")
xml2::read_html("<camelCase/>")


options(oai.xml_invalid_as="")

res <- list_records(url="https://pbn.nauka.gov.pl/OAI-PMH",
                    prefix="pbn",
                    as = "raw",
                    from = "2015-05-14T19:04:00Z",
                    until = "2015-05-14T19:04:50Z",
                    config=httr::verbose() )
length(res)

res <- list_records(url="https://pbn.nauka.gov.pl/OAI-PMH",
                    prefix="pbn",
                    as = "raw",
                    from = "2015-05-14T19:04:00Z",
                    until = "2015-05-14T19:34:50Z",
                    config=httr::verbose() )

res <- list_records(url="https://pbn.nauka.gov.pl/OAI-PMH",
                    token = "HgAAAVA8a0OuAAABTVPP2QAAAAFNU-wTkAADcGJuAQAFq3Y",
                    as = "raw",
                    config=httr::verbose() )


aa <- list_identifiers(from = "2015-09-03T00:00:00Z", until="2015-09-03T00:30:00Z", as="raw")
z <- aa[1]
xml <- xml2::read_xml(z)
ns <- xml2::xml_ns(xml)
xml2::xml_find_all(xml, "d1:OAI-PMH/d1:ListIdentifiers/*[local-name()='resumptionToken']", ns=ns )
xml2::xml_find_all(xml, "/d1:OAI-PMH/d1:ListIdentifiers/*[local-name()='resumptionToken']", ns=ns )
xml2::xml_find_all(xml, "/*[local-name()='OAI-PMH']/*[local-name()='ListIdentifiers']/*[local-name()='resumptionToken']")
get_token(xml, verb="ListIdentifiers")
