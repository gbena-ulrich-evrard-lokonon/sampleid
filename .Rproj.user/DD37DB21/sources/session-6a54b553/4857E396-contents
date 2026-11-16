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

comparison <- compare_id_sets(
  list(
    bacterial = bacterial,
    viral = viral,
    metadata = metadata
  )
)

# Display results
comparison$summary

comparison$shared_ids

comparison$file_specific_ids

comparison$presence_matrix
