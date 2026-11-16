test_that("read_sample_table imports a complete CSV table", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("BEN001", "BEN002"),
    Species_A = c(10, 20)
  )

  write.csv(data, file, row.names = FALSE)

  result <- read_sample_table(file, "Sample_ID")

  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 2)
  expect_equal(result$Sample_ID, c("BEN001", "BEN002"))
  expect_type(result$Sample_ID, "character")
})

test_that("read_sample_table preserves leading zeros", {

  file <- tempfile(fileext = ".csv")

  data <- data.frame(
    Sample_ID = c("001", "002", "003")
  )

  write.csv(data, file, row.names = FALSE)

  result <- read_sample_table(file, "Sample_ID")

  expect_equal(result$Sample_ID, c("001", "002", "003"))
})

test_that("read_sample_table rejects an unknown ID column", {

  file <- tempfile(fileext = ".csv")

  write.csv(
    data.frame(Sample_ID = c("A", "B")),
    file,
    row.names = FALSE
  )

  expect_error(
    read_sample_table(file, "Unknown_ID")
  )
})
