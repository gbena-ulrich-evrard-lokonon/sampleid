#' Check Sample Identifier Consistency
#'
#' Identifies missing, empty, and whitespace-related issues
#' in a vector of sample identifiers.
#'
#' This function performs basic quality control on sample identifiers
#' by detecting missing values, empty strings, whitespace-only
#' strings, and leading or trailing whitespace.
#'
#' @param ids A character vector containing sample identifiers
#'   to be checked.
#'
#' @return A data frame reporting the detected issues, with
#'   the following columns:
#'   \describe{
#'     \item{position}{The position of the problematic identifier
#'     in the input vector.}
#'     \item{original_id}{The original sample identifier associated
#'     with the detected issue.}
#'     \item{issue}{The type of issue detected. Possible values are
#'     \code{"missing_id"}, \code{"empty_id"}, and
#'     \code{"leading_trailing_whitespace"}.}
#'   }
#'
#'   If no issues are detected, an empty data frame with the same
#'   three columns is returned.
#'
#' @details
#' The function performs three checks:
#' \itemize{
#'   \item Missing identifiers represented by \code{NA}.
#'   \item Empty identifiers, including strings containing only
#'   whitespace characters.
#'   \item Identifiers containing leading or trailing whitespace.
#' }
#'
#' Leading and trailing whitespace is detected using
#' \code{trimws()}, without modifying the original identifiers.
#'
#' Each detected issue is reported with its original position
#' in the input vector. The function does not modify, remove,
#' or automatically correct problematic identifiers.
#'
#' @examples
#' sample_ids <- c(
#'   "Sample_001",
#'   NA,
#'   "",
#'   "   ",
#'   " Sample_004",
#'   "Sample_005 "
#' )
#'
#' check_consistency(sample_ids)
#'
#' @seealso
#' [check_duplicates()], [normalize_ids()],
#' [id_quality_report()]
#'
#' @export

check_consistency <- function(ids) {

  # 1. Validate input
  if (!is.character(ids)) {
    stop("Input must be a character vector.",
         call. = FALSE)
  }

  # 2. Identify missing IDs
  missing <- which(is.na(ids))

  # 3. Identify empty or whitespace-only IDs
  empty <- which(
    !is.na(ids) & !nzchar(trimws(ids))
  )

  # 4. Identify leading or trailing whitespace
  whitespace <- which(
    !is.na(ids) &
      nzchar(trimws(ids)) &
      ids != trimws(ids)
  )

  # 5. Build report
  issues <- list()

  if (length(missing) > 0) {
    issues[[length(issues) + 1]] <- data.frame(
      position = missing,
      original_id = ids[missing],
      issue = "missing_id"
    )
  }

  if (length(empty) > 0) {
    issues[[length(issues) + 1]] <- data.frame(
      position = empty,
      original_id = ids[empty],
      issue = "empty_id"
    )
  }

  if (length(whitespace) > 0) {
    issues[[length(issues) + 1]] <- data.frame(
      position = whitespace,
      original_id = ids[whitespace],
      issue = "leading_trailing_whitespace"
    )
  }

  # 6. Return report
  if (length(issues) == 0) {
    return(data.frame(
      position = integer(),
      original_id = character(),
      issue = character()
    ))
  }

  do.call(rbind, issues)
}
