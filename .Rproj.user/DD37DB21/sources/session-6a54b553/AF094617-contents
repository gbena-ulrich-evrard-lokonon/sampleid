test_that("normalize_ids converts identifiers to uppercase", {
  ids <- c("ano-001", "Ano-002")

  result <- normalize_ids(ids)

  expect_equal(result, c("ANO-001", "ANO-002"))
})


test_that("normalize_ids replaces spaces and underscores", {
  ids <- c("ANO 001", "ANO_002")

  result <- normalize_ids(ids)

  expect_equal(result, c("ANO-001", "ANO-002"))
})


test_that("normalize_ids preserves missing values", {
  ids <- c("ANO-001", NA, "ANO-003")

  result <- normalize_ids(ids)

  expect_equal(result, c("ANO-001", NA, "ANO-003"))
})


test_that("normalize_ids preserves leading zeros", {
  ids <- c("ANO-001", "ANO-010")

  result <- normalize_ids(ids)

  expect_equal(result, c("ANO-001", "ANO-010"))
})


test_that("normalize_ids supports lowercase output", {
  ids <- c("ANO_001", "ANO_002")

  result <- normalize_ids(ids, case = "lower")

  expect_equal(result, c("ano-001", "ano-002"))
})


test_that("normalize_ids rejects invalid input", {
  expect_error(normalize_ids(123))
  expect_error(normalize_ids("ANO-001", case = "incorrect"))
  expect_error(normalize_ids("ANO-001", separator = "ABC"))
  expect_error(normalize_ids("ANO-001", trim = "yes"))
})
