bacterial <- c(
  "BEN001",
  "BEN002",
  "BEN003"
)

viral <- c(
  "BEN-001",
  "BEN-002",
  "BEN-004"
)

metadata <- c(
  "Sample_001",
  "Sample_002",
  "Sample_003",
  "Sample_004"
)

# Explicit correspondence table
mapping <- data.frame(
  file = c(
    "viral", "viral", "viral",
    "metadata", "metadata", "metadata", "metadata"
  ),
  original_id = c(
    "BEN-001", "BEN-002", "BEN-004",
    "Sample_001", "Sample_002",
    "Sample_003", "Sample_004"
  ),
  canonical_id = c(
    "BEN001", "BEN002", "BEN004",
    "BEN001", "BEN002", "BEN003", "BEN004"
  ),
  stringsAsFactors = FALSE
)

result <- reconcile_samples(
  id_list = list(
    bacterial = bacterial,
    viral = viral,
    metadata = metadata
  ),
  mapping = mapping
)

# Display harmonized matching table
result$matches

# Display complete matches
result$common_samples

# Display source-to-canonical mapping
result$source_mapping
