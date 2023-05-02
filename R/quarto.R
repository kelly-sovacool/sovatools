#' Get image height in inches given dimensions in pixels and width in inches
#' @export
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
get_height_inches <- function(width_pixels, height_pixels, width_inches = 6.5) {
    return(height_pixels / width_pixels * width_inches)
}

#' Get image dimensions in inches from a file path
#' @export
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
get_image_dims <- function(image_path, width_inches = 6.5) {
    img_info <- magick::image_info(here::here(magick::image_read(strip_leading_slash(image_path))))
    height_in <- get_height_inches(img_info$width, img_info$height,
                                   width_inches = width_inches) %>%
        round(.,1)
    return(glue::glue('("{image_path}"){{width="{width_inches}in" height="{height_in}in"}}'))
}

#' Strip the leading slash from a string
#'
#' @export
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
strip_leading_slash <- function(x) {
    return(stringr::str_remove(x, "^/"))
}
