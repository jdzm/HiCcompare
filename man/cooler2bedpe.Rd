% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cooler2bedpe.R
\name{cooler2bedpe}
\alias{cooler2bedpe}
\title{Read a .cool file into R and output the data in BEDPE format}
\usage{
cooler2bedpe(path)
}
\arguments{
\item{path}{The path to a .cool file on your disk.}
}
\value{
A list with two items. Item 1, "cis"
    contains the intra-chromosomal contact matrices,
    one per chromosome.
    Item 2, "trans" contains the inter-chromsomal
    contact matrix.
}
\description{
Read a .cool file into R and output the data in BEDPE format
}
\details{
.cool files are HDF5 containers that store Hi-C data.
    Many public Hi-C datasets are available in .cool format
    on the mirnylab ftp site \url{ftp://cooler.csail.mit.edu/coolers}.
    To use these files in HiCcompare simply download the .cool file
    and read it into R using this function. This function will dump
    the contents of the file and format them into BEDPE format in R.
    The resulting object cant then be used in HiCcompare.
}
\examples{
\dontrun{
 dat <- cooler2bedpe(path = "path/to/cool/file.cool")
}
}
