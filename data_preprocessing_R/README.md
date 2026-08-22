# Data preprocessing and spatial modeling (R)

This folder contains the R / Quarto pipeline that turns raw field data into a single, complete, analysis-ready table. It is organized as eleven documents meant to be read and run in numeric order, with one exception (`11_inla_standalone_script.qmd`) explained below.

## Files

| File | What it does |
|---|---|
| `01_yield_data_preprocessing.qmd` | Imports the sugarcane yield/quality table, standardizes column types, and looks at how blocks and parcels change composition and naming over campaigns (parcels get renamed, subdivided or merged over the years, so this step builds a change-tracking table used later to align parcel identities across time). |
| `02_soil_data_preprocessing.qmd` | Imports the soil sample table, standardizes categorical fields, and matches soil parcel identifiers against the yield table's parcel identifiers, including a string-cleaning step to fix mismatches caused by spacing/casing differences in how parcel names were entered by different technicians. |
| `03_rainfall_data_preprocessing.qmd` | Imports daily rainfall logs from the station network, assesses missingness (a heatmap of missing days per station per month), and produces monthly aggregates. |
| `04_weather_data_preprocessing.qmd` | Imports the weather station table (temperature, humidity, evaporation), cleans and renames columns, and runs the same missingness diagnostics as the rainfall step. |
| `05_foliar_data_preprocessing.qmd` | Imports the foliar diagnostic table, classifies variables (dates, numerics, factors) based on domain knowledge, and looks at farm/parcel structure over campaigns. |
| `06_inla_spatial_preprocessing.qmd` | Imports the parcel shapefile, reprojects it to UTM Zone 28N (the correct projected CRS for this study area, in Senegal), computes parcel centroids, derives the irrigation type label (gravity vs drip) from the block code, and filters the attribute table down to the columns needed downstream. |
| `07_inla_modelling.qmd` | Builds the spatial neighbourhood (adjacency) matrix from parcel boundary distances and fits the Besag conditional autoregressive model, per soil variable and per campaign, to reconstruct missing soil measurements. See the root `README.md` for the mathematical specification of the model. |
| `08_inla_cross_validation_granulometry_correction.qmd` | Wraps the imputation in a 5-fold cross-validation loop to check predictive accuracy, and applies an isometric log-ratio (ILR) transform to the sand/silt/clay granulometry fractions so the CAR model respects the compositional (sum-to-100) constraint. |
| `09_pca_analysis_and_results_plotting.qmd` | Runs PCA on the completed soil/yield variable set, produces scree plots and biplots, and reports how many components are needed to reach 80/90/95 percent explained variance. |
| `10_data_fusion.qmd` | Merges the imputed soil GeoPackage with the sugarcane yield CSV on parcel and campaign/year, producing the single combined dataset handed off to the Python side. This is meant to be the last step, run after the INLA modeling is complete. |
| `11_inla_standalone_script.qmd` | A self-contained variant of the imputation step using a simple train/validation split instead of 5-fold CV. Kept for reference on how the ILR-based compositional correction was originally worked out; not part of the numbered production chain. |

## Running

Each file can be rendered on its own with Quarto:

```bash
quarto render 01_yield_data_preprocessing.qmd
```

or opened and stepped through interactively in RStudio. File paths (`setwd`, explicit read paths) are set near the top of each document and need to point at your local copy of the raw data before running.

## Required packages

See `../R/install_packages.R` for the full installation script. R-INLA (used in `06` through `08` and `11`) is installed from its own repository, not CRAN.
