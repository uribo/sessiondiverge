#' Write and Reload \R{} Session
#'
#' @description Write and Reload \R{} Session
#' include library attach conditions.
#'
#' @inheritParams base::load
#' @param pkgs logical. If *FALSE*, load only \R{} objects.
#' @importFrom utils sessionInfo
#' @name read_session
#' @examples
#' \dontrun{
#'
#' library(ggplot2)
#' p <-
#' ggplot(iris, aes(Sepal.Length, Petal.Width)) +
#' geom_point()
#'
#' write_session("my_session.Rdata")
#'
#' # Restart R...
#' read_session("my_session.Rdata")
#' p + theme_bw()
#' }
NULL

#' @rdname read_session
#' @export
write_session <- function(file) {

  # nolint start
  .loaded_pkgs <-
    unique(c(sessionInfo()$basePkgs,
             names(sessionInfo()$otherPkgs)))
  # nolint end

  assign(x = ".loaded_pkgs",
         value = .loaded_pkgs,
         pos = parent.frame())
  save.image(file = file)
}

#' @rdname read_session
#' @export
read_session <- function(file, pkgs = TRUE) {

  load(file = file, envir = parent.frame())
  .loaded_pkgs <- get(".loaded_pkgs")

  if (pkgs == TRUE) {
    eval(expr = expression(invisible(lapply(.loaded_pkgs,
                                            library,
                                            character.only = TRUE))),
         envir = parent.frame())
  }

  rm(.loaded_pkgs, envir = parent.frame())
}
