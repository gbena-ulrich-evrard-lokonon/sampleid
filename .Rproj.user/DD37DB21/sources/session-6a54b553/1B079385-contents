#' Check for Duplicate Sample Identifiers
#'
#' Identifies duplicated sample identifiers in a character vector
#' and reports their occurrence counts and positions.
#'
#' This function helps detect repeated sample identifiers before
#' performing sample matching, data integration, or downstream
#' analyses.
#'
#' @param ids A character vector containing sample identifiers
#'   to be checked.
#'
#' @return A data frame containing one row per duplicated sample
#'   identifier, with the following columns:
#'   \describe{
#'     \item{sample_id}{The duplicated sample identifier.}
#'     \item{count}{The total number of occurrences of the
#'     identifier in the input vector.}
#'     \item{positions}{The positions of all occurrences of the
#'     duplicated identifier in the original input vector,
#'     separated by commas.}
#'   }
#'
#'   Missing values (\code{NA}) are ignored during duplicate
#'   detection.
#'
#'   If no duplicated identifiers are detected, an empty data
#'   frame with the same three columns is returned.
#'
#' @details
#' Duplicate detection is based on exact string matching.
#' Identifiers that differ in capitalization, punctuation,
#' or whitespace are treated as distinct values.
#'
#' Missing values are excluded from the analysis, but empty
#' strings and whitespace-only strings are not automatically
#' removed.
#'
#' The function reports all occurrences of each duplicated
#' identifier, including its first occurrence.
#' It does not modify or automatically remove duplicated
#' identifiers.
#'
#' @examples
#' sample_ids <- c(
#'   "Sample_001",
#'   "Sample_002",
#'   "Sample_001",
#'   "Sample_003",
#'   "Sample_002",
#'   NA
#' )
#'
#' check_duplicates(sample_ids)
#'
#' @seealso
#' [check_consistency()], [check_collisions()],
#' [id_quality_report()]
#'
#' @export

check_duplicates <- function(ids) {

  # Validate input
  if (!is.character(ids)) {
    stop("`ids` must be a character vector.", call. = FALSE)
  }

  # Ignore missing values
  valid_ids <- ids[!is.na(ids)]

  # Identify duplicated identifiers
  duplicated_ids <- unique(
    valid_ids[duplicated(valid_ids)]
  )

  # Return an empty result if no duplicates exist
  if (length(duplicated_ids) == 0) {
    return(data.frame(
      sample_id = character(),
      count = integer(),
      positions = character(),
      stringsAsFactors = FALSE
    ))
  }

  # Build duplicate report
  result <- data.frame(
    sample_id = duplicated_ids,
    count = vapply(
      duplicated_ids,
      function(id) sum(valid_ids == id),
      integer(1)
    ),
    positions = vapply(
      duplicated_ids,
      function(id) {
        paste(which(!is.na(ids) & ids == id), collapse = ", ")
      },
      character(1)
    ),
    stringsAsFactors = FALSE
  )

  return(result)
}
