

# Create a test dataset
bacterial_data <- data.frame(
  Sample_ID = c("BEN001", "BEN002", "BEN003"),
  Species = c("Species_A", "Species_B", "Species_C"),
  Abundance = c(120, 85, 210)
)

# Save as CSV
write.csv(
  bacterial_data,
  "bacterial_matrix.csv",
  row.names = FALSE
)

# Read sample IDs
sample_ids <- read_sample_ids(
  file = "bacterial_matrix.csv",
  id_column = "Sample_ID"
)

# Display results
print(sample_ids)
