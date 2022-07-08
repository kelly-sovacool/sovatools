#' Throw an error if required packages are not installed.
#'
#' Reports which packages need to be installed and the parent function name.
#' See \url{https://stackoverflow.com/questions/15595478/how-to-get-the-name-of-the-calling-function-inside-the-called-routine}
#' This is only intended to be used inside a function. It will error otherwise.
#'
#' Adapted from [mikropml](abort_packages_not_installed)
#'
#' @param ... Package name(s) to check
#' @export
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
#'
#' @examples
#' \dontrun{
#' your_function <- function() {
#'   abort_packages_not_installed("base")
#'   abort_packages_not_installed("not-a-package-name", "dplyr", "non_package")
#' }
#' your_function()
#' }
abort_packages_not_installed <- function(...) {
  package_status <- sapply(c(...), requireNamespace, quietly = TRUE)
  parent_fcn_name <- sub("\\(.*$", "\\(\\)", deparse(sys.calls()[[sys.nframe() - 1]]))
  packages_not_installed <- Filter(isFALSE, package_status)
  if (length(packages_not_installed) > 0) {
    msg <- paste0(
      "The following package(s) are required for `", parent_fcn_name,
      "` but are not installed: \n  ",
      paste0(names(packages_not_installed), collapse = ", ")
    )
    stop(msg)
  }
}

#' Get package dependencies as a tibble
#'
#' @param package name of an R package
#'
#' @return a tibble with the package's recursive dependencies
#' @export
#'
#' @examples
#' get_deps_tbl('mikropml')
get_deps_tbl <- function(package) {
    abort_packages_not_installed(c('purrr', 'tidyr'))
    # https://stackoverflow.com/questions/14645363/listing-r-package-dependencies-without-installing-packages
    pkg_deps <- tools::package_dependencies(packages = package,
                                            recursive = TRUE)[[package]] %>%
        sort()
    all_deps <- tools::package_dependencies(packages = pkg_deps)
    deps_tbl <- dplyr::tibble(
        Package = names(all_deps),
        data = purrr::map(all_deps, dplyr::as_tibble)
    ) %>%
        tidyr::unnest(.data[["data"]])
    return(deps_tbl)
}
