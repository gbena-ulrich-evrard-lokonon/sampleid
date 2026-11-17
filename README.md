**sampleid**

<p align="center">
  <img src="man/figures/logo.jpeg"
       alt="sampleid logo"
       width="300">
</p>

<p align="center">
  <strong>Biological Sample Identifier Management and Validation</strong>
</p>

<p align="center">
  Reliable Biological Sample Identification Across Research Datasets
</p>

<!-- BADGES: Reserve this space for CRAN, R-universe, GitHub Actions and license badges -->

---

**Overview**

**sampleid** is an R package designed to improve the management, standardization, validation, and harmonization of biological sample identifiers across research datasets and analytical workflows.

Accurate sample identification is essential for reliable biological data analysis. Inconsistencies in sample identifiers can lead to incorrect sample matching, duplicate records, data integration errors, and potentially misleading scientific conclusions.

In genomics, metagenomics, transcriptomics, and other data-intensive biological disciplines, sample identifiers frequently need to be compared and harmonized across multiple files, experimental datasets, and analytical workflows.

**sampleid** provides a collection of tools to address these challenges by helping researchers detect identifier inconsistencies, identify duplicates and collisions, assess data quality, and reconcile sample identifiers across datasets.

The package aims to strengthen data integrity, traceability, and reproducibility throughout biological research workflows.

**Key Features**

**- Identifier normalization:** Standardize biological sample identifiers.

**- Duplicate detection:** Identify repeated sample identifiers.

**- Collision detection:** Detect distinct original identifiers that become identical after normalization.

**- Consistency assessment:** Identify missing values, empty identifiers, and whitespace inconsistencies.

**- Sample matching:** Match sample identifiers across datasets.

**- Cross-dataset comparison:** Compare identifier sets and identify discrepancies.

**- Sample reconciliation:** Support the harmonization of sample identifiers across datasets.

**- Quality reporting:** Generate reports describing identifier quality.

**- Sample data import:** Extract sample identifiers and read sample tables.

**Installation**

**Install from GitHub**

Install the development version directly from GitHub:

install.packages("remotes")

remotes::install_github(
  "gbena-ulrich-evrard-lokonon/sampleid"
)

**Install from the local source**

During development, install the package from its project directory:

devtools::install()

**Load the package**

library(sampleid)

**Available Functions**

<table>
  <thead>
    <tr>
      <th>Function</th>
      <th>Purpose</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>normalize_ids()</code></td>
      <td>Standardize sample identifiers.</td>
    </tr>
    <tr>
      <td><code>check_duplicates()</code></td>
      <td>Identify duplicate identifiers.</td>
    </tr>
    <tr>
      <td><code>check_collisions()</code></td>
      <td>Detect normalization-related identifier collisions.</td>
    </tr>
    <tr>
      <td><code>check_consistency()</code></td>
      <td>Assess identifier consistency.</td>
    </tr>
    <tr>
      <td><code>compare_id_sets()</code></td>
      <td>Compare sample identifier sets.</td>
    </tr>
    <tr>
      <td><code>match_samples()</code></td>
      <td>Match sample identifiers across datasets.</td>
    </tr>
    <tr>
      <td><code>reconcile_samples()</code></td>
      <td>Reconcile sample identifiers.</td>
    </tr>
    <tr>
      <td><code>id_quality_report()</code></td>
      <td>Generate identifier quality reports.</td>
    </tr>
    <tr>
      <td><code>read_sample_ids()</code></td>
      <td>Extract sample identifiers from supported files.</td>
    </tr>
    <tr>
      <td><code>read_sample_table()</code></td>
      <td>Import sample tables.</td>
    </tr>
  </tbody>
</table>

**Quick Start**

**1. Read sample identifiers**

"read_sample_ids()" extracts sample identifiers from supported CSV and Excel files.

ids <- read_sample_ids(
  file = "sample_metadata.csv",
  id_column = "Sample_ID"
)

head(ids)

Supported file formats:

- CSV (".csv")
- Excel (".xlsx")
- Excel 97–2003 (".xls")

Note: TSV files are not currently supported by "read_sample_ids()".

**2. Normalize sample identifiers**

Use "normalize_ids()" to standardize sample identifiers before comparing or integrating datasets.

**3. Detect duplicate identifiers**

Use "check_duplicates()" to identify repeated sample identifiers.

**4. Detect identifier collisions**

Use "check_collisions()" to identify distinct original identifiers that share the same normalized identifier.

This is particularly important when standardizing identifiers from different biological datasets.

**5. Assess identifier consistency**

Use "check_consistency()" to identify missing identifiers, empty values, and whitespace-related inconsistencies.

Detailed usage examples for these functions will be added as the package documentation develops.

Scientific Applications

**sampleid** is designed for biological research workflows involving:

- Genomics and comparative genomics
- Metagenomics and shotgun sequencing
- Metatranscriptomics
- Transcriptomics and RNA-seq
- Microbial diversity studies
- Molecular epidemiology
- Multi-dataset biological data integration

The package is intended to support researchers, bioinformaticians, molecular biologists, and computational biologists working with biological sample metadata and analytical datasets.

**Reproducibility and Data Integrity**

Reliable sample identification is a fundamental requirement for reproducible biological research.

By providing tools for identifier validation, normalization, duplicate detection, collision detection, and cross-dataset reconciliation, sampleid aims to reduce avoidable data management errors and improve the reliability of downstream analyses.

**Development and Testing**

**sampleid** is developed in R and follows a structured testing approach using the "testthat" framework.

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

**License**

This package is distributed under the MIT License.

See the "LICENSE" file for details.

**Author**

Gbèna Ulrich Evrard Lokonon

Molecular Biologist & Bioinformatician

Email: ulrichlokn@gmail.com

**Contributions**

Suggestions, bug reports, and contributions are welcome.

Please use the "GitHub Issues" (https://github.com/gbena-ulrich-evrard-lokonon/sampleid/issues) page to report bugs, suggest improvements, or discuss potential features.

**Citation**

If you use sampleid in scientific research, please cite the package using its official citation information, which will be provided upon publication.


<p align="center">
  <strong>sampleid</strong><br>
  <em>Reliable Biological Sample Identification Across Research Datasets.</em>
</p><p align="center">
  Developed with R for the biological research community.
</p>
