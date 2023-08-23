
# Shrinkage Methods Comparison in R Shiny

This Shiny app provides an interface to analyze datasets using Ridge, LASSO, and Elastic Net regression.

## Features

- Allows users to choose a built-in dataset (`mtcars`) or upload their own CSV file.
- Users can select the response variable from the dataset.
- For Elastic Net regression, users have the option to select the `alpha` value.
- Calculates and displays the Mean Squared Error (MSE) and lambda for each method.
- Visualizes the coefficient paths for each method.
- Displays an overview of the selected dataset.

## Usage

1. **Dataset Selection**: 
    - Use the dropdown menu to select the built-in `mtcars` dataset or choose "Upload CSV" to use your own dataset.
    - If you select "Upload CSV", you'll see an option to upload your CSV file.

2. **Response Variable**: 
    - Once the dataset is loaded, choose the response variable for the regression analysis from the dropdown list.

3. **Alpha for Elastic Net**: 
    - Use the slider to set the `alpha` parameter for Elastic Net regression. An alpha of `0` denotes LASSO regression, while an alpha of `1` denotes Ridge regression.

4. **Run Analysis**: 
    - Click the "Run Analysis" button to perform the regression analysis on the dataset.

5. **Tabs**:
    - **Data Overview**: Displays the first few rows of your dataset.
    - **Coefficient Paths**: Visualizes the coefficient paths for Ridge, LASSO, and Elastic Net.
    - **Results**: Displays the Mean Squared Error (MSE) and optimal lambda value for each method.

## Requirements

Make sure you have R and Shiny installed. Also, ensure the following R packages are installed:

- `shiny`
- `glmnet`
- `DT`
- `ggplot2`

## Getting Started

1. Clone this repository or download the Shiny app R script.
2. Open the R script in R or RStudio.
3. Run the script to launch the Shiny app.


For further reading on these methods:
- Tibshirani, R. (1996). Regression shrinkage and selection via the lasso. Journal of the Royal Statistical Society: Series B (Methodological), 58(1), 267-288.
- Zou, H., & Hastie, T. (2005). Regularization and variable selection via the elastic net. Journal of the Royal Statistical Society: Series B (Statistical Methodology), 67(2), 301-320.
- Hoerl, A. E., & Kennard, R. W. (1970). Ridge regression: Biased estimation for nonorthogonal problems. Technometrics, 12(1), 55-67.

