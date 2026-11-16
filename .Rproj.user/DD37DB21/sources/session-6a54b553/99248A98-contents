test_that("compare_id_sets identifies shared identifiers", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003"),
    metadata = c("BEN001", "BEN002", "BEN003")
  )

  result <- compare_id_sets(files)

  expect_true("BEN001" %in% result$shared_ids)
  expect_equal(length(result$shared_ids), 3)
})

test_that("compare_id_sets identifies file-specific IDs", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003")
  )

  result <- compare_id_sets(files)

  expect_equal(
    result$file_specific_ids$bacterial,
    "BEN002"
  )

  expect_equal(
    result$file_specific_ids$viral,
    "BEN003"
  )
})

test_that("compare_id_sets creates presence matrix", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN001", "BEN003")
  )

  result <- compare_id_sets(files)

  expect_true(result$presence_matrix["BEN001", "bacterial"])
  expect_true(result$presence_matrix["BEN001", "viral"])

  expect_false(result$presence_matrix["BEN002", "viral"])
})

test_that("compare_id_sets rejects unnamed files", {

  files <- list(
    c("BEN001"),
    c("BEN002")
  )

  expect_error(compare_id_sets(files))
})

test_that("compare_id_sets rejects fewer than two files", {

  expect_error(
    compare_id_sets(list(bacterial = c("BEN001")))
  )
})

test_that("compare_id_sets rejects non-character identifiers", {

  files <- list(
    bacterial = 1:3,
    viral = c("BEN001", "BEN002", "BEN003")
  )

  expect_error(compare_id_sets(files))
})
