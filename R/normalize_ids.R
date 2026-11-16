#' Normalize biological sample identifiers
#'
#' Standardize the textual representation of sample identifiers
#' without changing their original biological identity.
#'
#' @param ids A character vector containing sample identifiers.
#' @param case Letter case: "upper", "lower", or "none".
#' @param separator Character used to replace spaces and underscores.
#' @param trim Remove leading and trailing whitespace.
#'
#' @return A character vector of normalized identifiers.
#' @export
normalize_ids <- function(
    ids,
    case = "upper",
    separator = "-",
    trim = TRUE
) {

  # 1. Check input type
  if (!is.character(ids)) {
    stop("`ids` must be a character vector.")
  }

  # 2. Check case argument
  case <- match.arg(case, choices = c("upper", "lower", "none"))

  # 3. Check separator
  # Check separator
  if (!is.character(separator) ||
      length(separator) != 1 ||
      is.na(separator) ||
      nchar(separator) != 1 ||
      !grepl("^[[:punct:]]$", separator) ||
      separator == "\\") {
    stop("`separator` must be one punctuation character.")
  }

  # Check trim
  if (!is.logical(trim) || length(trim) != 1 || is.na(trim)) {
    stop("`trim` must be TRUE or FALSE.")
  }

  # 4. Preserve missing values
  result <- ids

  # 5. Select non-missing identifiers
  valid <- !is.na(result)

  # 6. Trim whitespace
  if (trim) {
    result[valid] <- trimws(result[valid])
  }

  # 7. Replace spaces and underscores
  result[valid] <- gsub("[[:space:]_]+", separator, result[valid])

  # 8. Apply letter case
  if (case == "upper") {
    result[valid] <- toupper(result[valid])
  } else if (case == "lower") {
    result[valid] <- tolower(result[valid])
  }

  return(result)
}
