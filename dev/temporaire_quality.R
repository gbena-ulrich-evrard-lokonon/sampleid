sample_ids <- c(
  "Sample-001",
  "sample_001",
  "Sample-002",
  "Sample-003",
  "Sample-003",
  NA_character_,
  "",
  " Sample-007 "
)

normalized_ids <- c(
  "sample001",
  "sample001",
  "sample002",
  "sample003",
  "sample003",
  NA_character_,
  "",
  "sample007"
)

report <- id_quality_report(
  sample_ids,
  normalized_ids
)

# Display overall status
report$status

# Display quality indicators
report$summary

# Display individual anomalies
report$consistency
report$duplicates
report$collisions
