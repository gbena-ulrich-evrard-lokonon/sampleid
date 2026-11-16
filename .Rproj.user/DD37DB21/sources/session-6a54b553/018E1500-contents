test_that("read_sample_ids reads CSV files", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("BEN001", "BEN002", "BEN003"),
    Abundance = c(10, 20, 30)
  )

  write.csv(data, file, row.names = FALSE)

  result <- read_sample_ids(file, "Sample_ID")

  expect_equal(
    result,
    c("BEN001", "BEN002", "BEN003")
  )
})


test_that("read_sample_ids preserves leading zeros", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("001", "002", "003")
  )

  write.csv(data, file, row.names = FALSE)

  result <- read_sample_ids(file, "Sample_ID")

  expect_equal(
    result,
    c("001", "002", "003")
  )
})


test_that("read_sample_ids accepts column index", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("BEN001", "BEN002"),
    Abundance = c(10, 20)
  )

  write.csv(data, file, row.names = FALSE)

  result <- read_sample_ids(file, 1)

  expect_equal(
    result,
    c("BEN001", "BEN002")
  )
})


test_that("read_sample_ids rejects TSV files", {

  file <- tempfile(fileext = ".tsv")

  writeLines(
    c(
      "Sample_ID",
      "BEN001",
      "BEN002"
    ),
    file
  )

  expect_error(
    read_sample_ids(file, "Sample_ID"),
    "Could not detect a supported file format."
  )
})


test_that("read_sample_ids rejects missing columns", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("BEN001", "BEN002")
  )

  write.csv(data, file, row.names = FALSE)

  expect_error(
    read_sample_ids(file, "Unknown_ID"),
    "Requested ID column was not found."
  )
})


test_that("read_sample_ids rejects nonexistent files", {

  expect_error(
    read_sample_ids(
      "nonexistent_file.csv",
      "Sample_ID"
    ),
    "File does not exist."
  )
})


test_that("read_sample_ids rejects unsupported formats", {

  file <- tempfile(fileext = ".txt")

  writeLines(
    c(
      "Sample_ID",
      "BEN001",
      "BEN002"
    ),
    file
  )

  expect_error(
    read_sample_ids(file, "Sample_ID"),
    "Could not detect a supported file format."
  )
})
