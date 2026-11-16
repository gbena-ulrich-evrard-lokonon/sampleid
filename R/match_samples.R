#' Match Sample Identifiers Across Multiple Files
#'
#' Compare sample identifiers across two or more datasets
#' and identify shared and file-specific samples.
#'
#' @param id_list A named list of character vectors.
#' Each element represents the sample identifiers
#' extracted from one file. List names must be unique
#' and non-empty.
#'
#' @return A list containing:
#' \describe{
#'   \item{matches}{A data frame indicating the presence
#'   of each sample in each file.}
#'   \item{common_samples}{Identifiers present in every file.}
#'   \item{missing_by_file}{A named list of identifiers
#'   missing from each file.}
#'   \item{summary}{A summary of total and matched samples
#'   for each file.}
#'   \item{presence_matrix}{A logical matrix indicating
#'   sample presence across files.}
#' }
#'
#' @examples
#' bacterial <- c("BEN001", "BEN002", "BEN003")
#' viral <- c("BEN001", "BEN003", "BEN004")
#'
#' result <- match_samples(list(
#'   bacterial = bacterial,
#'   viral = viral
#' ))
#'
#' result$common_samples
#'
#' @export
match_samples <- function(id_list) {

  # 1. Validate input
  if (!is.list(id_list) || length(id_list) < 2) {
    stop(
      "Input must be a list containing at least two files.",
      call. = FALSE
    )
  }

  if (is.null(names(id_list)) ||
      anyNA(names(id_list)) ||
      any(!nzchar(names(id_list))) ||
      anyDuplicated(names(id_list))) {
    stop(
      "Each file must have a unique, non-empty name.",
      call. = FALSE
    )
  }

  if (!all(vapply(id_list, is.character, logical(1)))) {
    stop(
      "Each file must contain character identifiers.",
      call. = FALSE
    )
  }

  # 2. Reject missing and empty identifiers
  for (i in seq_along(id_list)) {
    ids <- id_list[[i]]

    if (anyNA(ids) || any(!nzchar(trimws(ids)))) {
      stop(
        paste(
          "Missing or empty identifiers found in file:",
          names(id_list)[i]
        ),
        call. = FALSE
      )
    }
  }

  # 3. Remove repeated IDs within each file for matching
  clean_ids <- lapply(id_list, unique)

  # 4. Build the complete set of sample identifiers
  all_ids <- sort(unique(unlist(
    clean_ids,
    use.names = FALSE
  )))

  # 5. Build presence matrix
  presence <- do.call(
    cbind,
    lapply(clean_ids, function(ids) {
      all_ids %in% ids
    })
  )

  rownames(presence) <- all_ids
  colnames(presence) <- names(clean_ids)

  # 6. Count the number of files containing each sample
  n_files <- rowSums(presence)

  # 7. Determine matching status
  match_status <- ifelse(
    n_files == length(clean_ids),
    "complete",
    "partial"
  )

  # 8. Build matching table
  matches <- data.frame(
    sample_id = all_ids,
    as.data.frame(presence, check.names = FALSE),
    n_files = as.integer(n_files),
    match_status = match_status,
    check.names = FALSE
  )

  # 9. Identify samples present in every file
  common_samples <- all_ids[
    n_files == length(clean_ids)
  ]

  # 10. Identify samples missing from each file
  missing_by_file <- lapply(
    seq_along(clean_ids),
    function(i) {
      all_ids[!presence[, i]]
    }
  )

  names(missing_by_file) <- names(clean_ids)

  # 11. Build summary
  summary <- data.frame(
    file = names(clean_ids),
    total_samples = vapply(
      clean_ids, length, integer(1)
    ),
    matched_samples = colSums(
      presence & (n_files == length(clean_ids))
    ),
    stringsAsFactors = FALSE
  )

  # 12. Return results
  list(
    matches = matches,
    common_samples = common_samples,
    missing_by_file = missing_by_file,
    summary = summary,
    presence_matrix = presence
  )
}
