################################################################################
# Gulf of Mexico Shark Fisheries Landings (2000-2024)
################################################################################
#
# Juan Carlos Villaseñor-Derbez
# jc_villasenor@miami.edu
# May 26, 2026
#
# Downloads and processes Mexican commercial fisheries landings data from the
# mex_landings repository (Villaseñor-Derbez & Longnecker, 2025). Filters for
# elasmobranch species (tiburón and cazón) reported in the five Gulf of Mexico
# states (Tamaulipas, Veracruz, Tabasco, Campeche, Yucatán), and aggregates
# annual live and landed weights by year, state, species group, and species
# name. Exports the result as both RDS and CSV files to data/.
#
# Source data are pinned to a specific commit in the mex_landings repository to
# ensure reproducibility.
#
# Output: data/gulf_shark_landings_2000_2024.rds
#         data/gulf_shark_landings_2000_2024.csv
#
################################################################################

# SET UP #######################################################################

# Load packages ----------------------------------------------------------------
pacman::p_load(
  here,
  tidyverse
)

# Cite: Juan Carlos Villaseñor-Derbez, & Longnecker, A. (2025). mex-fisheries/mex_landings: v0.0.1 (v0.0.1). Zenodo. https://doi.org/10.5281/zenodo.17592475
# Load data --------------------------------------------------------------------
point_in_time <- "https://github.com/mex-fisheries/mex_landings/raw/ce8c53e249f19043239d26e6c68b6fe93dc13c9f"

# These contain 2000-2019
data_early <- readRDS(url(paste0(point_in_time, "/data/clean/mex_conapesca_avisos_2000_2019.rds"))) |>
  filter(year_cut <= 2017)

# These contain 2018-present(ish)
data_recent <- readRDS(url(paste0(point_in_time, "/data/clean/mex_conapesca_apertura_2018_present.rds"))) |> 
  filter(year_cut <= 2024)

# Vector of gulf states
gulf_states <- c("TAMAULIPAS", "VERACRUZ", "TABASCO", "CAMPECHE", "YUCATAN")

# PROCESSING ###################################################################

# Combine and select columns ---------------------------------------------------
shark_landings <- bind_rows(data_early,
                            data_recent) |> 
  filter(state %in% gulf_states,
         main_species_group == "TIBURON" | main_species_group == "CAZON") |>
  rename(year = year_cut) |> 
  group_by(year,
           state,
           main_species_group,
           species_name) |> 
  summarize(live_weight = sum(live_weight, na.rm = T),
            landed_weight = sum(landed_weight, na.rm = T),
            .groups = "drop")

# EXPORT #######################################################################

## The final step --------------------------------------------------------------
write_rds(x = shark_landings,
          file = here("data/gulf_shark_landings_2000_2024.rds"))
write_csv(x = shark_landings,
          file = here("data/gulf_shark_landings_2000_2024.csv"))