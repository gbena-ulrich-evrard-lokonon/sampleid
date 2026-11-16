test_that("reconcile_samples harmonizes identifiers", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN-001", "BEN-002")
  )

  mapping <- data.frame(
    file = c("viral", "viral"),
    original_id = c("BEN-001", "BEN-002"),
    canonical_id = c("BEN001", "BEN002")
  )

  result <- reconcile_samples(files, mapping)

  expect_equal(
    result$common_samples,
    c("BEN001", "BEN002")
  )
})

test_that("reconcile_samples preserves original identifiers", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN-001", "BEN-002")
  )

  mapping <- data.frame(
    file = c("viral", "viral"),
    original_id = c("BEN-001", "BEN-002"),
    canonical_id = c("BEN001", "BEN002")
  )

  result <- reconcile_samples(files, mapping)

  expect_true(
    "BEN-001" %in% result$source_mapping$original_id
  )

  expect_true(
    "BEN001" %in% result$source_mapping$canonical_id
  )
})

test_that("reconcile_samples preserves unmapped IDs", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN-001", "BEN-003")
  )

  mapping <- data.frame(
    file = "viral",
    original_id = "BEN-001",
    canonical_id = "BEN001"
  )

  result <- reconcile_samples(files, mapping)

  expect_true("BEN-003" %in%
                result$source_mapping$canonical_id)
})

test_that("reconcile_samples detects collisions", {

  files <- list(
    bacterial = c("BEN001", "BEN002"),
    viral = c("BEN-001", "BEN-002")
  )

  mapping <- data.frame(
    file = c("viral", "viral"),
    original_id = c("BEN-001", "BEN-002"),
    canonical_id = c("BEN001", "BEN001")
  )

  expect_error(reconcile_samples(files, mapping))
})

test_that("reconcile_samples rejects unknown file names", {

  files <- list(
    bacterial = "BEN001",
    viral = "BEN-001"
  )

  mapping <- data.frame(
    file = "unknown",
    original_id = "BEN-001",
    canonical_id = "BEN001"
  )

  expect_error(reconcile_samples(files, mapping))
})

test_that("reconcile_samples rejects invalid mappings", {

  files <- list(
    bacterial = "BEN001",
    viral = "BEN-001"
  )

  mapping <- data.frame(
    file = "viral",
    original_id = "UNKNOWN",
    canonical_id = "BEN001"
  )

  expect_error(reconcile_samples(files, mapping))
})
