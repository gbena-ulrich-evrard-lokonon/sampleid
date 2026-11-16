r_files <- list.files(
  "R",
  pattern = "\\.R$",
  full.names = TRUE
)

for (f in r_files) {
  lines <- readLines(f, warn = FALSE)

  hits <- grep(
    "install\\.packages|update\\.packages|chooseCRANmirror",
    lines,
    value = TRUE
  )

  if (length(hits) > 0) {
    cat("\nFichier :", f, "\n")
    print(hits)
  }
}
