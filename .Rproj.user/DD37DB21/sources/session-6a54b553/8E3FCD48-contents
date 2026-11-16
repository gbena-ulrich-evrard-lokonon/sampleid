
#' Compare Sample Identifier Sets
#'
#' Compare sample identifiers across multiple datasets
#' to identify shared and dataset-specific identifiers.
#'
#' @param id_list A named list of character vectors.
#' Each element represents the identifiers from one dataset.
#' Names must be unique and non-empty.
#'
#' @return A list containing:
#' \describe{
#'   \item{summary}{A data frame summarizing the number
#'   of identifiers in each dataset.}
#'   \item{shared_ids}{Identifiers shared across datasets.}
#'   \item{file_specific_ids}{Identifiers specific to
#'   individual datasets.}
#'   \item{presence_matrix}{A logical matrix indicating
#'   identifier presence across datasets.}
#' }
#'
#' @examples
#' bacterial <- c("BEN001", "BEN002", "BEN003")
#' viral <- c("BEN001", "BEN003", "BEN004")
#'
#' result <- compare_id_sets(list(
#'   bacterial = bacterial,
#'   viral = viral
#' ))
#'
#' result$shared_ids
#'
#' @export

compare_id_sets <- function(id_list) {

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

  # 2. Remove missing and empty identifiers
  clean_ids <- lapply(id_list, function(ids) {
    ids <- ids[!is.na(ids)]
    ids <- ids[nzchar(trimws(ids))]
    unique(ids)
  })

  # 3. Identify all unique identifiers
  all_ids <- sort(unique(unlist(clean_ids, use.names = FALSE)))

  # 4. Build presence/absence matrix
  presence <- do.call(
    cbind,
    lapply(clean_ids, function(ids) {
      all_ids %in% ids
    })
  )

  rownames(presence) <- all_ids
  colnames(presence) <- names(clean_ids)

  # 5. Identify shared and file-specific IDs
  presence_count <- rowSums(presence)

  shared_ids <- all_ids[presence_count >= 2]

  file_specific_ids <- lapply(
    seq_along(clean_ids),
    function(i) {
      all_ids[presence[, i] & presence_count == 1]
    }
  )

  names(file_specific_ids) <- names(clean_ids)

  # 6. Build summary
  summary <- data.frame(
    file = names(clean_ids),
    unique_identifiers = vapply(
      clean_ids, length, integer(1)
    ),
    shared_identifiers = colSums(
      presence & (presence_count >= 2)
    ),
    file_specific_identifiers = colSums(
      presence & (presence_count == 1)
    ),
    stringsAsFactors = FALSE
  )

  # 7. Return complete comparison
  list(
    summary = summary,
    shared_ids = shared_ids,
    file_specific_ids = file_specific_ids,
    presence_matrix = presence
  )
}
