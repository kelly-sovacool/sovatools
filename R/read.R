read_yaml_as_tbl <- function(filepath) {
  return(yaml::read_yaml(filepath) %>% purrr::map_dfr(tibble::as_tibble_row))
} 