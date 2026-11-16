test_that("check_collisions detects normalized collisions", {

  original <- c("Sample-001", "sample_001", "Sample-002")
  normalized <- c("sample001", "sample001", "sample002")

  result <- check_collisions(original, normalized)

  expect_equal(nrow(result), 1)
  expect_equal(result$normalized_id, "sample001")
  expect_equal(result$count, 2)
})

test_that("check_collisions ignores repeated identical IDs", {

  original <- c("Sample-001", "Sample-001")
  normalized <- c("sample001", "sample001")

  result <- check_collisions(original, normalized)

  expect_equal(nrow(result), 0)
})

test_that("check_collisions handles no collisions", {

  original <- c("Sample-001", "Sample-002")
  normalized <- c("sample001", "sample002")

  result <- check_collisions(original, normalized)

  expect_equal(nrow(result), 0)
})

test_that("check_collisions handles missing values", {

  original <- c(
    "Sample-001",
    "Sample-002",
    NA_character_
  )

  normalized <- c(
    "sample001",
    "sample001",
    NA_character_
  )

  result <- check_collisions(original, normalized)

  expect_equal(nrow(result), 1)
  expect_equal(result$normalized_id, "sample001")
  expect_equal(result$count, 2)
  expect_equal(result$original_ids,
               "Sample-001, Sample-002")
  expect_equal(result$positions, "1, 2")
})

test_that("check_collisions rejects unequal vector lengths", {

  expect_error(
    check_collisions(
      c("Sample-001", "Sample-002"),
      "sample001"
    )
  )
})

test_that("check_collisions rejects invalid input", {

  expect_error(
    check_collisions(1:3, c("a", "b", "c"))
  )
})
