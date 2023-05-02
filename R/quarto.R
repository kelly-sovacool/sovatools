get_height_inches <- function(width_pixels, height_pixels, width_inches = 6.5) {
    return(height_pixels / width_pixels * width_inches)
}
get_image_dims <- function(image_path, width_inches = 6.5) {
    img_info <- magick::image_info(magick::image_read(image_path))
    height_in <- get_height_inches(img_info$width, img_info$height,
                                   width_inches = width_inches) %>%
        round(.,1)
    return(glue('("{image_path}"){{width="{width_inches}in" height="{height_in}in"}}'))
}
