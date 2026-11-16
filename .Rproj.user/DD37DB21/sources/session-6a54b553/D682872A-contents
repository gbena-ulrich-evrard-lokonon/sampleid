test_that("id_quality_report detects all quality issues", {

  ids <- c(
    "Sample-001",
    "sample_001",
    "Sample-002",
    "Sample-003",
    "Sample-003",
    NA_character_,
    "",
    " Sample-007 "
  )

  normalized <- c(
    "sample001",
    "sample001",
    "sample002",
    "sample003",
    "sample003",
    NA_character_,
    "",
    "sample007"
  )

  report <- id_quality_report(ids, normalized)

  expect_equal(report$status, "issues_detected")

  expect_equal(
    report$summary$value,
    c(8, 1, 1, 1, 1, 1)
  )
})

test_that("id_quality_report passes clean identifiers", {

  ids <- c("Sample001", "Sample002", "Sample003")

  normalized <- c("sample001", "sample002", "sample003")

  report <- id_quality_report(ids, normalized)

  expect_equal(report$status, "passed")

  expect_true(all(report$summary$value == c(3, 0, 0, 0, 0, 0)))
})

test_that("id_quality_report rejects unequal vector lengths", {

  expect_error(
    id_quality_report(
      c("Sample001", "Sample002"),
      "sample001"
    )
  )
})

test_that("id_quality_report rejects invalid inputs", {

  expect_error(
    id_quality_report(1:3, c("a", "b", "c"))
  )
})
