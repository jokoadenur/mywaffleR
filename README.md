![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![CRAN Version](https://img.shields.io/badge/CRAN-7.3.2-brightgreen)
![Open Issues](https://img.shields.io/badge/open%20issues-0-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

![WhatsApp Image 2025-01-27 at 18 15 45](https://github.com/user-attachments/assets/67261f99-5a55-420c-bf6c-6dabf5f83991)


# mywaffleR

`mywaffleR` is an R package designed for visualizing data in the form of waffle charts with a hundred grids. It allows you to create waffle chart based on variables or categories in your data.

## Installation

To install the `mywaffleR` package, run the following code in your R script:

```R
# Install package from GitHub
devtools::install_github("jokoadenur/mywaffleR")
```

> **Note:** If prompted to update certain packages (options like 1. All, 2. CRAN, etc.), simply press **ENTER** to skip. Wait until the installation process is complete and the message `DONE (mywaffleR)` appears.

After installation, activate the package with the following code:

```R
# Activate the package
library(mywaffleR)
```

## Usage

To create a waffle chart with 100 grids, use the mywaffler() function with a dataset containing at least two columns: text (for category labels) and value (for category values)

```R
mywaffler(data)
```

### Examples:

1. Simple data with additional columns:
   ```R
   data <- data.frame(
   text = c("A", "B", "C", "D", "E", "F"),
   value = c(20, 45, 60, 75, 80, 67))

   mywaffler(data, "text", "value")
   ```
2. Data with customized colors:
   ```R
   data <- data.frame(
   text = c("A", "B", "C", "D", "E"),
   value = c(20, 45, 60, 75, 20),
   color = c("#ff1493", "#ff6361", "#bc5090", "#50508d", "#60508d"))

   mywaffler(data, "text", "value", "color")
   ```
### Data Requirements:
  To use the mywaffler() function effectively, your data must contain at least two columns:
  
  text: The category or label
  
  value: The value each category
