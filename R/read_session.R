#' Write and Reload \R{} Session
#'
#' @description Write and Reload \R{} Session
#' include library attach conditions.
#'
#' @inheritParams base::load
#' @param pkgs logical. If *FALSE*, load only \R{} objects.
#' @param pickup character vector or *NULL*. If a given variable exists,
#' only that variable is read into the workspace.
#' @importFrom purrr invoke
#' @importFrom rlang expr sym
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

  .loaded_pkgs <-
    unique(c(sessionInfo()$basePkgs,
             names(sessionInfo()$otherPkgs)))

  assign(x = ".loaded_pkgs",
         value = .loaded_pkgs,
         pos = parent.frame())
  save.image(file = file)
}

#' @rdname read_session
#' @export
read_session <- function(file, pkgs = TRUE, pickup = NULL) {

  # load(file = file)

  objs <-
    load(file = file)

  if (!is.null(pickup)) {
    objs <-
      objs[objs %in% c(pickup, ".loaded_pkgs")]
  }

  for (x in 1:length(objs)) {
    purrr::invoke(assign,
                  x = objs[x],
                  value = eval(expr = rlang::expr(!! rlang::sym(objs[x]))),
                  pos = parent.frame())
  }

  if (pkgs == TRUE) {
    .loaded_pkgs <-
      get(".loaded_pkgs")

    eval(expr = expression(
      invisible(
        lapply(.loaded_pkgs,
               library,
               character.only = TRUE))),
      envir = parent.frame())
  }
  rm(.loaded_pkgs, envir = parent.frame())
}
