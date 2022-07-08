#' sovatools theme for ggplot
#'
#' Uses `ggplot2::theme_bw()` and removes margins.
#'
#' @return list of ggproto objects
#' @export
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' ggplot(mtcars) +
#'   aes(x = mpg, y = wt, color = cyl) +
#'   geom_point()  +
#'   theme_sovatools()
#' }
theme_sovatools <- function() {
    abort_packages_not_installed('ggplot2')
    return(list(
        ggplot2::theme_bw(),
        ggplot2::theme(
            legend.margin = ggplot2::margin(0, 0, 0, 0, unit = "pt"),
            legend.box.margin = ggplot2::margin(0, 0, 0, 0, unit = "pt"),
            plot.margin = ggplot2::margin(0, 0, 0, 0, unit = "pt")
        ))
    )
}
