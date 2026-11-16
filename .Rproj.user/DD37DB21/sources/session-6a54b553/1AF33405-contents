#' Check for Sample Identifier Normalization Collisions
#'
#' Detects normalization collisions by identifying distinct original
#' sample identifiers that share the same normalized identifier.
#'
#' This function is useful for assessing the consistency and uniqueness
#' of sample identifiers after normalization, particularly before
#' integrating multiple datasets.
#'
#' @param original_ids A character vector containing the original
#'   sample identifiers.
#'
#' @param normalized_ids A character vector containing the corresponding
#'   normalized sample identifiers. Must have the same length as
#'   `original_ids`.
#'
#' @return A data frame containing one row per detected collision,
#'   with the following columns:
#'   \describe{
#'     \item{normalized_id}{The normalized identifier shared by
#'     multiple distinct original identifiers.}
#'     \item{original_ids}{The distinct original identifiers associated
#'     with the normalized identifier, separated by commas.}
#'     \item{count}{The number of distinct original identifiers
#'     associated with the normalized identifier.}
#'     \item{positions}{The original positions of the corresponding
#'     identifiers in the input vectors, separated by commas.}
#'   }
#'
#'   If no collisions are detected, an empty data frame with the
#'   same four columns is returned.
#'
#' @details
#' A normalization collision occurs when two or more distinct original
#' identifiers are transformed into the same normalized identifier.
#'
#' Missing values (`NA`) and empty strings are excluded from the
#' analysis. Repeated occurrences of the same original identifier
#' associated with the same normalized identifier are not considered
#' collisions.
#'
#' The function validates that both inputs are character vectors
#' of equal length. It does not modify the input identifiers or
#' automatically resolve detected collisions.
#'
#' @examples
#' original_ids <- c(
#'   "Sample-001",
#'   "sample_001",
#'   "Sample-002",
#'   "Sample-003"
#' )
#'
#' normalized_ids <- c(
#'   "sample001",
#'   "sample001",
#'   "sample002",
#'   "sample003"
#' )
#'
#' check_collisions(original_ids, normalized_ids)
#'
#' @seealso
#' [match_samples()], [reconcile_samples()]
#'
#' @export


check_collisions <- function(original_ids, normalized_ids) {

  # 1. Validate inputs
  if (!is.character(original_ids) ||
      !is.character(normalized_ids)) {
    stop("Both inputs must be character vectors.",
         call. = FALSE)
  }

  if (length(original_ids) != length(normalized_ids)) {
    stop("Both vectors must have the same length.",
         call. = FALSE)
  }

  # 2. Remove missing or empty identifiers
  valid <- !is.na(original_ids) &
    !is.na(normalized_ids) &
    nzchar(original_ids) &
    nzchar(normalized_ids)

  original <- original_ids[valid]
  normalized <- normalized_ids[valid]

  positions <- which(valid)

  # 3. Identify normalized IDs associated
  # with multiple distinct original IDs
  groups <- split(seq_along(normalized), normalized)

  collision_groups <- groups[
    vapply(groups, function(i) {
      length(unique(original[i])) > 1
    }, logical(1))
  ]

  # 4. Return an empty result if no collisions exist
  if (length(collision_groups) == 0) {
    return(data.frame(
      normalized_id = character(),
      original_ids = character(),
      count = integer(),
      positions = character(),
      stringsAsFactors = FALSE
    ))
  }

  # 5. Build collision report
  result <- lapply(names(collision_groups), function(id) {

    i <- collision_groups[[id]]

    data.frame(
      normalized_id = id,
      original_ids = paste(unique(original[i]),
                           collapse = ", "),
      count = length(unique(original[i])),
      positions = paste(positions[i],
                        collapse = ", "),
      stringsAsFactors = FALSE
    )
  })

  # 6. Combine results
  do.call(rbind, result)
}
