
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
    # https://stackoverflow.com/questions/14645363/listing-r-package-dependencies-without-installing-packages
    mikropml_deps <- tools::package_dependencies(packages = package,
                                                 recursive = TRUE)[[package]] %>%
        sort()
    all_deps <- tools::package_dependencies(packages = mikropml_deps)
    deps_tbl <- tibble::tibble(
        Package = names(all_deps),
        data = purrr::map(all_deps, tibble::as_tibble)
    ) %>%
        tidyr::unnest(data)
    deps_tbl %>% dplyr::filter(value == 'gtools')
}
