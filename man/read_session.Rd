% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_session.R
\name{read_session}
\alias{read_session}
\alias{write_session}
\alias{read_session}
\title{Write and Reload \R{} Session}
\usage{
write_session(file)

read_session(file, pkgs = TRUE, pickup = NULL)
}
\arguments{
\item{file}{a (readable binary-mode) \link{connection} or a character string
    giving the name of the file to load (when \link{tilde expansion}
    is done).}

\item{pkgs}{logical. If \emph{FALSE}, load only \R{} objects.}

\item{pickup}{character vector or \emph{NULL}. If a given variable exists,
only that variable is read into the workspace.}
}
\description{
Write and Reload \R{} Session
include library attach conditions.
}
\examples{
\dontrun{

library(ggplot2)
p <-
ggplot(iris, aes(Sepal.Length, Petal.Width)) +
geom_point()

write_session("my_session.Rdata")

# Restart R...
read_session("my_session.Rdata")
p + theme_bw()
}
}
