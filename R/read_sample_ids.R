#' Read Sample Identifiers
#'
#' Extract sample identifiers from a CSV or Excel file.
#'
#' This function imports a tabular file and extracts sample
#' identifiers from a specified column. Supported formats are
#' CSV, XLSX, and XLS. TSV files are not supported.
#'
#' @param file Path to the input file.
#' @param id_column Name or position of the sample ID column.
#' @param file_type File format: "auto", "csv", "xlsx", or "xls".
#'   Defaults to "auto".
#' @param sheet Excel sheet to import. Defaults to 1.
#'
#' @return A character vector containing sample identifiers.
#'
#' @details
#' The function automatically detects the file format from its
#' extension when `file_type = "auto"`.
#'
#' Supported formats:
#' - CSV files, imported using [readr::read_csv()].
#' - XLSX and XLS files, imported using [readxl::read_excel()].
#'
#' All columns are read as character data to preserve sample
#' identifiers, including leading zeros.
#'
#' Missing values in CSV files are not automatically interpreted
#' as missing identifiers.
#'
#' Files with unsupported extensions, including TSV files,
#' generate an error when automatic format detection is used.
#'
#' @examples
#' \dontrun{
#' # Read sample identifiers from a CSV file
#' ids <- read_sample_ids(
#'   file = "bacterial_matrix.csv",
#'   id_column = "Sample_ID"
#' )
#'
#' # Read sample identifiers from an Excel file
#' ids <- read_sample_ids(
#'   file = "sample_metadata.xlsx",
#'   id_column = 1,
#'   sheet = 1
#' )
#' }
#'
#' @seealso
#' [read_sample_table()], [check_consistency()]
#'
#' @export

read_sample_ids <- function(file, id_column, file_type = "auto",
                            sheet = 1) {

  # 1. Validate file path
  if (!is.character(file) || length(file) != 1 ||
      is.na(file) || !nzchar(file)) {
    stop("Provide one valid file path.", call. = FALSE)
  }

  if (!file.exists(file)) {
    stop("File does not exist.", call. = FALSE)
  }

  # 2. Validate ID column
  if (!(is.character(id_column) &&
        length(id_column) == 1 &&
        !is.na(id_column) &&
        nzchar(id_column)) &&
      !(is.numeric(id_column) &&
        length(id_column) == 1 &&
        !is.na(id_column) &&
        id_column >= 1 &&
        id_column == as.integer(id_column))) {
    stop(
      "id_column must be a column name or a positive integer.",
      call. = FALSE
    )
  }

  # 3. Detect file type
  allowed_types <- c("auto", "csv", "xlsx", "xls")

  if (!is.character(file_type) ||
      length(file_type) != 1 ||
      is.na(file_type) ||
      !file_type %in% allowed_types) {
    stop("Unsupported file_type.", call. = FALSE)
  }

  if (file_type == "auto") {

    file_type <- tolower(tools::file_ext(file))

    if (!file_type %in% allowed_types[-1]) {
      stop(
        "Could not detect a supported file format.",
        call. = FALSE
      )
    }
  }

  # 4. Read the file
  if (file_type == "csv") {

    data <- as.data.frame(
      readr::read_csv(
        file,
        col_types = readr::cols(
          .default = readr::col_character()
        ),
        na = character(),
        trim_ws = FALSE,
        name_repair = "minimal",
        show_col_types = FALSE
      ),
      check.names = FALSE
    )

  } else {

    data <- as.data.frame(
      readxl::read_excel(
        file,
        sheet = sheet,
        col_types = "text",
        .name_repair = "minimal"
      ),
      check.names = FALSE
    )
  }

  # 5. Identify requested column
  if (is.numeric(id_column)) {

    if (id_column > ncol(data)) {
      stop(
        "Requested column index does not exist.",
        call. = FALSE
      )
    }

    column_index <- as.integer(id_column)

  } else {

    column_index <- which(names(data) == id_column)

    if (length(column_index) == 0) {
      stop(
        "Requested ID column was not found.",
        call. = FALSE
      )
    }

    if (length(column_index) > 1) {
      stop(
        "The requested column name is ambiguous.",
        call. = FALSE
      )
    }
  }

  # 6. Extract sample identifiers
  ids <- data[[column_index]]

  # 7. Return character vector
  as.character(ids)
}
