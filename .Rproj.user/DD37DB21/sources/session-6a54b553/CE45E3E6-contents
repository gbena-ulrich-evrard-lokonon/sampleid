#' Read a Sample Table
#'
#' Import a complete sample-related table from a CSV or Excel file
#' while preserving all values as character data.
#'
#' @param file Path to the input file.
#' @param id_column Name or position of the sample ID column.
#' @param file_type File format: "auto", "csv", "xlsx", or "xls".
#'   Defaults to "auto".
#' @param sheet Excel sheet to import. Defaults to 1.
#'
#' @return A data frame containing the imported table, with all
#'   columns stored as character values.
#'
#' @details
#' The function automatically detects the file format from its
#' extension when `file_type = "auto"`.
#'
#' CSV files are imported using [readr::read_csv()], while Excel
#' files are imported using [readxl::read_excel()].
#'
#' All columns are imported as character values to preserve
#' sample identifiers, including leading zeros.
#'
#' The specified sample ID column is validated but the complete
#' table is returned without extracting or modifying its columns.
#'
#' @examples
#' \dontrun{
#' table <- read_sample_table(
#'   file = "bacterial_matrix.csv",
#'   id_column = "Sample_ID"
#' )
#'
#' metadata <- read_sample_table(
#'   file = "sample_metadata.xlsx",
#'   id_column = 1,
#'   sheet = 1
#' )
#' }
#'
#' @seealso
#' [read_sample_ids()], [check_consistency()]
#'
#' @export

read_sample_table <- function(file, id_column, file_type = "auto",
                              sheet = 1) {

  # 1. Validate file path
  if (!is.character(file) || length(file) != 1 ||
      is.na(file) || !nzchar(file)) {
    stop("Provide one valid file path.", call. = FALSE)
  }

  if (!file.exists(file)) {
    stop("File does not exist.", call. = FALSE)
  }

  # 2. Validate file type
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

  # 3. Import complete table
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

  # 4. Validate ID column
  if (is.numeric(id_column)) {

    if (length(id_column) != 1 ||
        is.na(id_column) ||
        id_column < 1 ||
        id_column != as.integer(id_column) ||
        id_column > ncol(data)) {
      stop("Invalid ID column index.", call. = FALSE)
    }

    column_index <- as.integer(id_column)

  } else if (is.character(id_column) &&
             length(id_column) == 1 &&
             !is.na(id_column) &&
             nzchar(id_column)) {

    column_index <- which(names(data) == id_column)

    if (length(column_index) == 0) {
      stop("ID column was not found.", call. = FALSE)
    }

    if (length(column_index) > 1) {
      stop("ID column name is ambiguous.", call. = FALSE)
    }

  } else {

    stop(
      "id_column must be a column name or a positive integer.",
      call. = FALSE
    )
  }

  # 5. Return complete table
  return(data)
}
