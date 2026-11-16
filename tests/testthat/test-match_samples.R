test_that("match_samples identifies complete matches", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003"),
    metadata = c("BEN001", "BEN002", "BEN003")
  )

  result <- match_samples(files)

  expect_equal(result$common_samples, "BEN001")
})

test_that("match_samples identifies partial matches", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003")
  )

  result <- match_samples(files)

  expect_equal(
    result$matches$match_status,
    c("complete", "partial", "partial")
  )
})

test_that("match_samples identifies missing samples", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003")
  )

  result <- match_samples(files)

  expect_equal(
    result$missing_by_file$bacterial,
    "BEN003"
  )

  expect_equal(
    result$missing_by_file$viral,
    "BEN002"
  )
})

test_that("match_samples creates presence matrix", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003")
  )

  result <- match_samples(files)

  expect_true(
    result$presence_matrix["BEN001", "bacterial"]
  )

  expect_false(
    result$presence_matrix["BEN002", "viral"]
  )
})

test_that("match_samples rejects missing identifiers", {

  files <- list(
    bacterial = c("BEN001", NA_character_),
    viral = c("BEN001", "BEN002")
  )

  expect_error(match_samples(files))
})

test_that("match_samples rejects duplicate file names", {

  files <- list(
    bacterial = c("BEN001"),
    bacterial = c("BEN002")
  )

  expect_error(match_samples(files))
})
