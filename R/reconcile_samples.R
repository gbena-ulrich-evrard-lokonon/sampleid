#' Reconcile Sample Identifiers Across Multiple Files
#'
#' Harmonize sample identifiers across multiple datasets
#' using an explicit mapping table while preserving
#' the original identifiers.
#'
#' @param id_list A named list of character vectors.
#' Each element represents the sample identifiers
#' from one file. Names must be unique and non-empty.
#' @param mapping An optional data frame containing
#' three character columns: file, original_id and
#' canonical_id. Defaults to NULL.
#'
#' @return A list containing:
#' \describe{
#'   \item{matches}{A data frame showing canonical
#'   identifiers and their presence across files.}
#'   \item{common_samples}{Canonical identifiers present
#'   in every file.}
#'   \item{source_mapping}{A data frame linking original
#'   identifiers to canonical identifiers.}
#'   \item{presence_matrix}{A logical matrix showing
#'   identifier presence across files.}
#' }
#'
#' @examples
#' bacterial <- c("BEN001", "BEN002")
#' viral <- c("BEN-001", "BEN-002")
#'
#' mapping <- data.frame(
#'   file = c("viral", "viral"),
#'   original_id = c("BEN-001", "BEN-002"),
#'   canonical_id = c("BEN001", "BEN002")
#' )
#'
#' result <- reconcile_samples(
#'   list(bacterial = bacterial, viral = viral),
#'   mapping
#' )
#'
#' result$common_samples
#'
#' @export



reconcile_samples <- function(id_list, mapping = NULL) {

  # 1. Validate input files
  if (!is.list(id_list) || length(id_list) < 2) {
    stop(
      "Input must contain at least two files.",
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
      "All identifiers must be character vectors.",
      call. = FALSE
    )
  }

  # 2. Validate identifiers
  for (i in seq_along(id_list)) {
    ids <- id_list[[i]]

    if (anyNA(ids) || any(!nzchar(trimws(ids)))) {
      stop(
        paste("Missing or empty identifiers in:", names(id_list)[i]),
        call. = FALSE
      )
    }
  }

  # 3. Prepare explicit mapping
  if (is.null(mapping)) {

    mapping <- data.frame(
      file = character(),
      original_id = character(),
      canonical_id = character(),
      stringsAsFactors = FALSE
    )

  } else {

    if (!is.data.frame(mapping) ||
        !all(c("file", "original_id", "canonical_id") %in%
             names(mapping))) {
      stop(
        "Mapping must contain file, original_id and canonical_id columns.",
        call. = FALSE
      )
    }

    mapping <- mapping[
      c("file", "original_id", "canonical_id")
    ]

    if (!all(vapply(mapping, is.character, logical(1)))) {
      stop(
        "All mapping columns must be character vectors.",
        call. = FALSE
      )
    }

    if (anyNA(mapping) ||
        any(!nzchar(trimws(mapping$file))) ||
        any(!nzchar(trimws(mapping$original_id))) ||
        any(!nzchar(trimws(mapping$canonical_id)))) {
      stop(
        "Mapping cannot contain missing or empty values.",
        call. = FALSE
      )
    }

    if (any(!mapping$file %in% names(id_list))) {
      stop(
        "Mapping contains unknown file names.",
        call. = FALSE
      )
    }

    if (anyDuplicated(mapping[c("file", "original_id")])) {
      stop(
        "Each original identifier can have only one mapping per file.",
        call. = FALSE
      )
    }

    # Check that mapping IDs exist in their source files
    for (i in seq_len(nrow(mapping))) {
      if (!mapping$original_id[i] %in%
          id_list[[mapping$file[i]]]) {
        stop(
          paste(
            "Original identifier not found in file:",
            mapping$original_id[i],
            mapping$file[i]
          ),
          call. = FALSE
        )
      }
    }
  }

  # 4. Apply mapping while preserving original IDs
  reconciled <- lapply(names(id_list), function(file_name) {

    original <- unique(id_list[[file_name]])

    file_mapping <- mapping[
      mapping$file == file_name,
      ,
      drop = FALSE
    ]

    canonical <- original

    if (nrow(file_mapping) > 0) {
      index <- match(
        original,
        file_mapping$original_id
      )

      mapped <- !is.na(index)

      canonical[mapped] <-
        file_mapping$canonical_id[index[mapped]]
    }

    # 5. Detect collisions within each file
    if (anyDuplicated(canonical)) {
      stop(
        paste(
          "Reconciliation collision detected in file:",
          file_name
        ),
        call. = FALSE
      )
    }

    data.frame(
      file = file_name,
      original_id = original,
      canonical_id = canonical,
      stringsAsFactors = FALSE
    )
  })

  names(reconciled) <- names(id_list)

  # 6. Build harmonized identifier sets
  canonical_sets <- lapply(
    reconciled,
    function(x) x$canonical_id
  )

  all_ids <- sort(unique(unlist(
    canonical_sets,
    use.names = FALSE
  )))

  # 7. Build presence matrix
  presence <- do.call(
    cbind,
    lapply(canonical_sets, function(ids) {
      all_ids %in% ids
    })
  )

  rownames(presence) <- all_ids
  colnames(presence) <- names(canonical_sets)

  # 8. Build matching table
  n_files <- rowSums(presence)

  matches <- data.frame(
    canonical_id = all_ids,
    as.data.frame(presence, check.names = FALSE),
    n_files = as.integer(n_files),
    match_status = ifelse(
      n_files == length(id_list),
      "complete",
      "partial"
    ),
    check.names = FALSE,
    stringsAsFactors = FALSE
  )

  # 9. Identify complete matches
  common_samples <- all_ids[
    n_files == length(id_list)
  ]

  # 10. Return reconciliation results
  list(
    matches = matches,
    common_samples = common_samples,
    source_mapping = do.call(rbind, reconciled),
    presence_matrix = presence
  )
}
