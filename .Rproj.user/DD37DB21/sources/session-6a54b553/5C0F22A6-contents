data <- data.frame(
  Sample_ID = c("BEN001", "BEN002", "BEN003"),
  Species_A = c(120, 85, 210),
  Species_B = c(45, 60, 90)
)

write.csv(data, "test_matrix.csv", row.names = FALSE)

result <- read_sample_table(
  file = "test_matrix.csv",
  id_column = "Sample_ID"
)

print(result)
str(result)
