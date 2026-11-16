bacterial <- c(
  "BEN001",
  "BEN002",
  "BEN003",
  "BEN004"
)

viral <- c(
  "BEN001",
  "BEN003",
  "BEN005"
)

metadata <- c(
  "BEN001",
  "BEN002",
  "BEN003",
  "BEN004",
  "BEN005",
  "BEN006"
)

matching <- match_samples(
  list(
    bacterial = bacterial,
    viral = viral,
    metadata = metadata
  )
)

# Complete matching table
matching$matches

# Samples found in every file
matching$common_samples

# Samples missing from each file
matching$missing_by_file

# Summary
matching$summary
