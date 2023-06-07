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
    img_info <- magick::image_info(magick::image_read(image_path))
    height_in <- get_height_inches(img_info$width, img_info$height,
                                   width_inches = width_inches) %>%
        round(.,1)
    return(glue::glue('width="{width_inches}in" height="{height_in}in"'))
}

#' Insert image in markdown
#' @export
#' @author Kelly Sovacool \email{sovacool@@umich.edu}
insert_image_md <- function(image_path, width_inches = 6.5) {
    dims <- get_image_dims(here::here(image_path))
    return(glue::glue('![](/{image_path}){{{dims}}}'))
}
