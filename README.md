**sampleid**

Biological Sample Identifier Management and Validation

"sampleid" is an R package designed to improve the management, standardization, validation, and harmonization of biological sample identifiers across research datasets and analytical workflows.

**Overview**

Accurate sample identification is essential for reliable biological data analysis. Inconsistencies in sample identifiers can lead to incorrect sample matching, duplicate records, data integration errors, and potentially misleading scientific conclusions.

In genomics, metagenomics, transcriptomics, and other data-intensive biological disciplines, sample identifiers frequently need to be compared and harmonized across multiple files, experimental datasets, and analytical workflows.

"sampleid" provides a collection of tools to address these challenges by helping researchers detect identifier inconsistencies, identify duplicates and collisions, assess data quality, and reconcile sample identifiers across datasets.

The package aims to strengthen data integrity, traceability, and reproducibility throughout biological research workflows.

Key Features

- Identifier normalization: Standardize biological sample identifiers.
- Duplicate detection: Identify repeated sample identifiers.
- Collision detection: Detect distinct original identifiers that become identical after normalization.
- Consistency assessment: Identify missing values, empty identifiers, and whitespace inconsistencies.
- Sample matching: Match sample identifiers across datasets.
- Cross-dataset comparison: Compare identifier sets and identify discrepancies.
- Sample reconciliation: Support the harmonization of sample identifiers across datasets.
- Quality reporting: Generate reports describing identifier quality.
- Sample data import: Extract sample identifiers and read sample tables.

Installation

Install from the local source

During development, install the package from its project directory:

devtools::install()

Load the package

library(sampleid)

A public installation link will be provided when the package is published on GitHub.

Available Functions

Function| Purpose
"normalize_ids()"| Standardize sample identifiers.
"check_duplicates()"| Identify duplicate identifiers.
"check_collisions()"| Detect normalization-related identifier collisions.
"check_consistency()"| Assess identifier consistency.
"compare_id_sets()"| Compare sample identifier sets.
"match_samples()"| Match samples across datasets.
"reconcile_samples()"| Reconcile sample identifiers.
"id_quality_report()"| Generate identifier quality reports.
"read_sample_ids()"| Extract sample identifiers from supported files.
"read_sample_table()"| Import sample tables.

Quick Start

1. Read sample identifiers

"read_sample_ids()" extracts sample identifiers from CSV and Excel files.

ids <- read_sample_ids(
  file = "sample_metadata.csv",
  id_column = "Sample_ID"
)

head(ids)

The function supports:

- CSV files (".csv")
- Excel files (".xlsx")
- Excel 97–2003 files (".xls")

TSV files are not supported by "read_sample_ids()".

**2. Normalize sample identifiers**

Use "normalize_ids()" to standardize sample identifiers before comparing or integrating datasets.

#Example to be completed with the package's normalization options.

**3. Detect duplicate identifiers**

Use "check_duplicates()" to identify repeated sample identifiers.

#Example to be completed with the function's documented input and output.

**4. Detect identifier collisions**

Use "check_collisions()" to identify distinct original identifiers that share the same normalized identifier.

This is particularly important when standardizing identifiers from different biological datasets.

**5. Assess identifier consistency**

Use "check_consistency()" to identify missing identifiers, empty values, and whitespace-related inconsistencies.

Scientific Applications

"sampleid" is designed for biological research workflows involving:

- Genomics and comparative genomics
- Metagenomics and shotgun sequencing
- Metatranscriptomics
- Transcriptomics and RNA-seq
- Microbial diversity studies
- Molecular epidemiology
- Multi-dataset biological data integration

The package is intended to support researchers, bioinformaticians, molecular biologists, and computational biologists working with biological sample metadata and analytical datasets.

Reproducibility and Data Integrity

Reliable sample identification is a fundamental requirement for reproducible biological research.

By providing tools for identifier validation, normalization, duplicate detection, collision detection, and cross-dataset reconciliation, "sampleid" aims to reduce avoidable data management errors and improve the reliability of downstream analyses.

Development and Testing

"sampleid" is developed in R and follows a structured testing approach using the "testthat" framework.

Run the automated tests with:

devtools::test()

Check the package with:

devtools::check()

Dependencies

Imports

- "readr"
- "readxl"

Suggested

- "testthat" (version 3.0.0 or later)

License

This package is distributed under the MIT License.

Author

Gbèna Ulrich Evrard Lokonon

Molecular Biologist & Bioinformatician

Email: ulrichlokn@gmail.com

Contributions

Suggestions, bug reports, and contributions are welcome. Please use the project's issue tracker once the public repository is available.

Citation

If you use "sampleid" in scientific research, please cite the package using its official citation information, which will be provided upon publication.


sampleid - Reliable Biological Sample Identification Across Research Datasets.
