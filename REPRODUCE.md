# Reproduction guide (draft)

## Prerequisites
- Stata 17 (for .do files)
- R >= 4.2 (for Salek.R). Recommend renv for package management.
- Access to Nepal DHS 2022 microdata via https://dhsprogram.com

## Steps
1. Obtain NPPR82FL.DTA and place in data/ or update paths
2. Run Data management.do to create BDHS_Nepal_Child_Clean.dta
3. Run Analysis.do for survey-weighted models
4. Run Salek.R for figures/maps (requires shapefile and Excel if used)
