#' Write and Reload \R{} Session
#'
#' @description Write and Reload R Session
#' include library attach conditions.
#'
#' @inheritParams base::load
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
         pos = .GlobalEnv)
  save.image(file = file)
}

#' @rdname read_session
#' @export
read_session <- function(file) {

  .loaded_pkgs <- NULL

  load(file = file, envir = .GlobalEnv)
  eval(expr = expression(invisible(lapply(.loaded_pkgs,
                                            library,
                                            character.only = TRUE))),
         envir = .GlobalEnv)

  rm(.loaded_pkgs, envir = .GlobalEnv)
}
