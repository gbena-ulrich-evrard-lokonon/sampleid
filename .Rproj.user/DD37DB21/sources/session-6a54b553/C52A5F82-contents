#' Generate a Sample Identifier Quality Report
#'
#' Evaluate the quality of sample identifiers by combining
#' consistency, duplicate and normalization collision checks.
#'
#' @param ids A character vector containing the original
#' sample identifiers.
#' @param normalized_ids A character vector containing the
#' corresponding normalized sample identifiers. Must have
#' the same length as `ids`.
#'
#' @return A list containing:
#' \describe{
#'   \item{status}{Overall quality status: "passed" or
#'   "issues_detected".}
#'   \item{summary}{A data frame containing quality metrics
#'   and their corresponding values.}
#'   \item{consistency}{Results of sample identifier
#'   consistency checks.}
#'   \item{duplicates}{Detected duplicate identifiers.}
#'   \item{collisions}{Detected normalization collisions.}
#' }
#'
#' @examples
#' ids <- c("BEN001", "BEN002", "BEN003")
#' normalized_ids <- normalize_ids(ids)
#'
#' report <- id_quality_report(ids, normalized_ids)
#'
#' report$status
#' report$summary
#'
#' @export

id_quality_report <- function(ids, normalized_ids) {

  # 1. Validate inputs
  if (!is.character(ids) ||
      !is.character(normalized_ids)) {
    stop("Both inputs must be character vectors.",
         call. = FALSE)
  }

  if (length(ids) != length(normalized_ids)) {
    stop("Both vectors must have the same length.",
         call. = FALSE)
  }

  # 2. Run quality checks
  consistency <- check_consistency(ids)

  duplicates <- check_duplicates(ids)

  collisions <- check_collisions(
    ids,
    normalized_ids
  )

  # 3. Calculate quality indicators
  n_missing <- sum(consistency$issue == "missing_id")

  n_empty <- sum(consistency$issue == "empty_id")

  n_whitespace <- sum(
    consistency$issue == "leading_trailing_whitespace"
  )

  n_duplicates <- nrow(duplicates)

  n_collisions <- nrow(collisions)

  # 4. Determine overall status
  has_issues <- (
    n_missing + n_empty + n_whitespace +
      n_duplicates + n_collisions
  ) > 0

  status <- if (has_issues) {
    "issues_detected"
  } else {
    "passed"
  }

  # 5. Build summary
  summary <- data.frame(
    metric = c(
      "total_identifiers",
      "missing_identifiers",
      "empty_identifiers",
      "whitespace_issues",
      "duplicate_groups",
      "collision_groups"
    ),
    value = c(
      length(ids),
      n_missing,
      n_empty,
      n_whitespace,
      n_duplicates,
      n_collisions
    )
  )

  # 6. Return complete report
  list(
    status = status,
    summary = summary,
    consistency = consistency,
    duplicates = duplicates,
    collisions = collisions
  )
}

