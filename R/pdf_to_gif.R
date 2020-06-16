#' Convert PDF to Animated GIF
#'
#' @param pdf_location
#'
#' @return
#' @export
#'
#' @examples
pdf_to_gif <- function(pdf_location, gif_file_path, gif_file_name, density = 50) {

  pdf_doc <- magick::image_read_pdf(pdf_location,
                                    density = 50)

  gif_file_name_and_path <- stringr::str_glue("{here::here()}/{gif_file_path}/{gif_file_name}.gif")

  # return(gif_file_name_and_path)

  pdf_doc %>%
    magick::image_animate(fps = 0.5) %>%
    magick::image_write(path = gif_file_name_and_path)

}

