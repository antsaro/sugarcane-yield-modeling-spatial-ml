# Machine learning modeling and interpretability (Python)

This folder picks up where `data_preprocessing_R/10_data_fusion.qmd` leaves off: it takes the fused soil/yield/weather table and runs feature selection, descriptive analysis, model benchmarking and interpretability analysis on it.

## Files

| File | What it does |
|---|---|
| `01_feature_selection_rfe_vif.ipynb` | Runs Recursive Feature Elimination with cross-validation (RFECV) using a random forest to rank predictors and pick a working feature set, then computes Variance Inflation Factors on the surviving predictors to flag remaining multicollinearity. |
| `02_data_visualization.ipynb` | Descriptive analysis: temporal trends of the key sugarcane variables, boxplots by irrigation type and by block, descriptive statistics tables for the whole dataset and split by irrigation type, and GAM-smoothed trend plots. |
| `03_ml_modelling_combined_dataset.ipynb` | Full model benchmarking on the pooled dataset (both irrigation types together): K-fold cross-validated comparison of linear, kernel, tree-based and boosting regressors on the TPER response, temporal decline analysis, SHAP summary and heatmap plots, and partial dependence plots (including stratified and categorical PDPs). |
| `04_ml_modelling_by_irrigation_type.ipynb` | The same modeling pipeline as `03`, but run separately for gravity-irrigated (GRV) and drip-irrigated (GAG) parcels, plus a stacking regressor combining the strongest individual models and side-by-side comparison plots (scatterplots, SHAP, PDP) between the two irrigation systems. |

## Models compared

Linear Regression, Ridge, Lasso, Elastic Net, K-Nearest Neighbours, Support Vector Regression, Decision Tree, Random Forest, Extra Trees, Gradient Boosting, Bagging, Voting Regressor, Stacking Regressor, XGBoost, LightGBM, CatBoost, and a small Multi-Layer Perceptron. All are evaluated with the same K-fold cross-validation split and reported on RMSE, MAE and R-squared (see the root `README.md` for the formulas).

## Running

```bash
pip install -r ../requirements.txt
jupyter lab
```

Open the notebooks in numeric order. Each notebook expects the fused CSV/GeoPackage produced by `10_data_fusion.qmd` — set the input path in the first configuration cell before running.

Note that `04_ml_modelling_by_irrigation_type.ipynb` is a large notebook (many cells produce multi-panel figures for both irrigation systems); running it end to end on a laptop can take a while, mostly because of the SHAP TreeExplainer calls and the hyperparameter search inside Optuna for the boosting models.
