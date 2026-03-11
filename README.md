# The Role of Inventory Expectations in the Crude Oil Market

This repository contains the replication material and code for the project  
**“The Role of Inventory Expectations in the Crude Oil Market: An Extension of Kilian (2009)”**, developed for the course *Advanced Macroeconometrics* at Université Paris Dauphine.

## Project Overview

The project replicates the structural VAR framework proposed by Kilian (2009) and extends it by incorporating **expected crude oil inventories** as an additional forward-looking variable.  
The objective is to improve the identification of oil price drivers by explicitly capturing the **precautionary demand component** that, in the original model, is absorbed by the oil-specific demand shock.

The analysis proceeds in three steps:

1. **Replication of Kilian (2009)** using the original sample (1974–2007).
2. **Extension of the sample** up to September 2025 to evaluate the robustness of the original results.
3. **Extended SVAR specification** including expected inventories, allowing the identification of an oil-specific precautionary demand shock.

The results show that incorporating inventory expectations helps explain part of the dynamics previously attributed to the residual oil-specific demand shock and improves the structural interpretation of oil price fluctuations.

## Repository Structure

- `AM_Project.qmd`  
  R Quarto file used for data construction and preprocessing.

- `MATLAB/`  
  Contains all MATLAB scripts used for estimation, impulse response analysis, and historical decompositions.

  Main subfolders:
  - `Replication/` – Replication of Kilian (2009) on the original sample.
  - `Replication_Extended/` – Replication using the extended dataset (1974–2025).
  - `Replication_2006_2025/` – Three-variable benchmark model on the shorter sample.
  - `Extension_Level/` – Four-variable SVAR including expected inventories.

- `Report.pdf`  
  Full paper describing the theoretical framework, empirical strategy, and results.

## Methodology

The empirical analysis relies on a **Structural Vector Autoregressive (SVAR)** model estimated using monthly data.  
The baseline specification includes:

- Global oil production growth
- Global real economic activity
- Real price of oil

The extended model augments the system with **expected U.S. crude oil inventories**, derived from the EIA Short-Term Energy Outlook (STEO).

Estimation is performed using least squares for the reduced-form VAR and structural identification based on recursive restrictions consistent with Kilian (2009).

## Requirements

- **MATLAB** (Econometrics Toolbox recommended)
- **R** with **Quarto** support (only required to rebuild the dataset)

The cleaned datasets required for estimation are already included in the repository.

## Author

Gabriele Piantoni  
MSc in Quantitative Economic Analysis  
Université Paris Dauphine – PSL
