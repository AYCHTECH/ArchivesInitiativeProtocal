context("Safe reading of XMLs")

skip_on_cran()

inputs <- c(
  "<p>Some paragraph with <b>text in bold</b> which should be OK</p>",
  "<p>Some paragraph with <b>also in bold</b> with a an illegal character \u0019</p>"
)

test_that("proper XML is parsed correctly", {
  expect_equal( as.character(read_xml_safely(inputs[1])),
                as.character(xml2::read_xml(inputs[1])) )
} )


test_that("Characters illegal in XML are removed", {
  expect_warning( res <- read_xml_safely(inputs[2]) )
  res2 <- xml2::read_xml( gsub("\u0019", "", inputs[2]) )
  expect_equal( as.character(res), as.character(res2))
} )


test_that("Illegal characters are removed when reading offending record in PBN", {
  ch <- httr::GET("https://pbn.nauka.gov.pl/OAI-PMH?verb=GetRecord&identifier=242743&metadataPrefix=pbn")
  tt <- httr::content(ch, "text")
  expect_error( xml2::read_xml(tt) )
  expect_warning( xml1 <- oai:::read_xml_safely(tt) )
  expect_warning( get_records("242743", as="raw", prefix="pbn", url="https://pbn.nauka.gov.pl/OAI-PMH") )
} )


rm(inputs)