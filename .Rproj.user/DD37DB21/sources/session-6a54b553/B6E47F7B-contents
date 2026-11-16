test_that("check_duplicates detects exact duplicates", {

  ids <- c("ANO-001", "ANO-002", "ANO-001")

  result <- check_duplicates(ids)

  expect_equal(nrow(result), 1)
  expect_equal(result$sample_id, "ANO-001")
  expect_equal(result$count, 2L)
  expect_equal(result$positions, "1, 3")
})


test_that("check_duplicates returns empty results when no duplicates exist", {

  ids <- c("ANO-001", "ANO-002", "ANO-003")

  result <- check_duplicates(ids)

  expect_equal(nrow(result), 0)
})


test_that("check_duplicates ignores missing values", {

  ids <- c("ANO-001", NA, "ANO-001", NA)

  result <- check_duplicates(ids)

  expect_equal(result$count, 2L)
})


test_that("check_duplicates rejects invalid input", {

  expect_error(check_duplicates(123))
})


test_that("check_duplicates handles empty vectors", {

  result <- check_duplicates(character())

  expect_equal(nrow(result), 0)
})
