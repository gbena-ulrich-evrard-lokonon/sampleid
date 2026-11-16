test_that("check_consistency detects missing IDs", {
  ids <- c("Sample01", NA_character_)

  result <- check_consistency(ids)

  expect_equal(nrow(result), 1)
  expect_equal(result$issue, "missing_id")
})

test_that("check_consistency detects empty IDs", {
  ids <- c("Sample01", "", "   ")

  result <- check_consistency(ids)

  expect_equal(nrow(result), 2)
  expect_true(all(result$issue == "empty_id"))
})

test_that("check_consistency detects surrounding whitespace", {
  ids <- c("Sample01", " Sample02 ")

  result <- check_consistency(ids)

  expect_equal(nrow(result), 1)
  expect_equal(
    result$issue,
    "leading_trailing_whitespace"
  )
})

test_that("check_consistency returns empty report when valid", {
  ids <- c("Sample01", "Sample02", "Sample03")

  result <- check_consistency(ids)

  expect_equal(nrow(result), 0)
})

test_that("check_consistency rejects invalid input", {
  expect_error(check_consistency(1:3))
})
