# install_packages.R
#
# Installs every R package used across data_preprocessing_R/*.qmd.
# Run this once before rendering any of the Quarto documents.
#
# R-INLA is not on CRAN and needs its own repository, so it is installed
# separately from everything else.

# --- R-INLA -------------------------------------------------------------
# Stable release channel. If this fails, check https://www.r-inla.org/download-install
# for the current repository URL, it occasionally changes.
if (!requireNamespace("INLA", quietly = TRUE)) {
  install.packages(
    "INLA",
    repos = c(getOption("repos"), INLA = "https://inla.r-inla-download.org/R/stable")
  )
}

# --- CRAN packages --------------------------------------------------------
cran_packages <- c(
  "pacman",
  "dplyr",
  "readr",
  "tidyr",
  "tidyverse",
  "stringr",
  "stringdist",
  "lubridate",
  "purrr",
  "tibble",
  "forcats",
  "data.table",
  "janitor",
  "skimr",
  "VIM",
  "summarytools",
  "Hmisc",
  "corrplot",
  "corrr",
  "gt",
  "DT",
  "jsonlite",
  "knitr",
  # spatial
  "sf",
  "sp",
  "terra",
  "spdep",
  "gstat",
  "automap",
  "units",
  # plotting
  "ggplot2",
  "ggpubr",
  "ggrepel",
  "ggridges",
  "ggsignif",
  "ggtext",
  "ggbeeswarm",
  "GGally",
  "gganimate",
  "transformr",
  "cowplot",
  "patchwork",
  "pheatmap",
  "plotly",
  "RColorBrewer",
  "viridis",
  "scales",
  "gridExtra",
  "grid",
  "reshape2",
  "magick",
  # compositional / multivariate / dimensionality
  "compositions",
  "FactoMineR",
  "factoextra",
  "explor",
  "broom",
  # time series / hydrology
  "forecast",
  "hydroTSM",
  "zoo",
  # regression / smoothing
  "mgcv",
  # parallel
  "parallel",
  "doParallel",
  "foreach"
)

installed <- rownames(installed.packages())
to_install <- setdiff(cran_packages, installed)

if (length(to_install) > 0) {
  install.packages(to_install, repos = "https://cloud.r-project.org")
}

cat("Done. Installed/verified", length(cran_packages), "CRAN packages plus INLA.\n")
