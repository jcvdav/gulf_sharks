# Landings Data for Mexican Shark Fisheries in the Gulf of Mexico

This repository contains aggregated commercial fisheries landings data for
elasmobranch species (sharks and small sharks/dogfish) recorded in the five
Mexican Gulf of Mexico states: Tamaulipas, Veracruz, Tabasco, Campeche, and
Yucatán. Data cover the period 2000–2024 and are derived from official
CONAPESCA landing records.

The primary purpose of this repository is **data sharing**. The `scripts/`
folder contains the code used to produce the data for replication purposes, but
the focus is on the derived datasets in `data/`.

---

## How to cite

**If you use the data**, please cite:

> Villaseñor-Derbez, J. C. (2026). *Landings Data for Mexican Shark Fisheries
> in the Gulf of Mexico* [Dataset]. GitHub. https://github.com/jcvdav/gulf_sharks

**If you use or adapt the code**, please cite:

> Villaseñor-Derbez, J. C. (2026). *gulf_sharks* [Software]. GitHub.
> https://github.com/jcvdav/gulf_sharks

---

## Data

Processed data files are located in `data/`:

| File | Format | Description |
|------|--------|-------------|
| [gulf_shark_landings_2000_2024.csv](data/gulf_shark_landings_2000_2024.csv) | CSV | Main dataset (plain text, recommended) |
| [gulf_shark_landings_2000_2024.rds](data/gulf_shark_landings_2000_2024.rds) | RDS | Same dataset in R binary format |

### Quick start

```r
# CSV (any tool)
df <- read.csv("data/gulf_shark_landings_2000_2024.csv")

# RDS (R only)
df <- readRDS("data/gulf_shark_landings_2000_2024.rds")
```

### Columns

| Column | Type | Description |
|--------|------|-------------|
| `year` | integer | Year of landing (2000–2024) |
| `state` | character | Mexican federal state (all caps): TAMAULIPAS, VERACRUZ, TABASCO, CAMPECHE, YUCATAN |
| `main_species_group` | character | Broad elasmobranch category: TIBURON (sharks) or CAZON (small sharks / dogfish) |
| `species_name` | character | Species name as recorded in CONAPESCA landing records. Combines commodity with common name (scientific name is sometimes available for >= 2018) |
| `live_weight` | numeric | Annual live weight (kg) summed within year × state × species group × species |
| `landed_weight` | numeric | Annual landed weight (kg) summed within year × state × species group × species |

---

## Replication

The script `scripts/get_data.R` reproduces the dataset from scratch. It
downloads landing records pinned to a specific commit of the upstream
`mex_landings` repository and applies the filters and aggregations described
above.

This project uses [renv](https://rstudio.github.io/renv/) for package
management. To restore the exact package versions used to produce the data,
run the following before executing the script:

```r
renv::restore()
source("scripts/get_data.R")
```

---

## Data Sources

The derived data in this repository are produced from:

> Juan Carlos Villaseñor-Derbez, & Longnecker, A. (2025).
> *mex-fisheries/mex_landings: v0.0.1* (v0.0.1). Zenodo.
> https://doi.org/10.5281/zenodo.17592475

Zenodo dataset DOI: [10.5281/zenodo.17592474](https://doi.org/10.5281/zenodo.17592474)

Original data are sourced from CONAPESCA (Comisión Nacional de Acuacultura y
Pesca) official landing records and are made available under CC-BY 4.0.

---

## Licensing

- **Code** in this repository is licensed under the MIT License (see `LICENSE`).
- **Data outputs** are licensed under CC-BY 4.0 (see `LICENSE-DATA`), consistent
  with the original source data license.
