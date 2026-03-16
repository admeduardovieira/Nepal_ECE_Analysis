# Nepal Early Childhood Education (ECE) Analysis

## Household Water and Handwashing Facilities and Early Childhood Education Participation in Nepal: Evidence from a Nationally Representative Cross-Sectional Survey

<div align="center">

[![License](https://img.shields.io/badge/License-MIT-10b981?style=for-the-badge&labelColor=0d1117&logo=opensourceinitiative&logoColor=10b981)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active%20Research-7c3aed?style=for-the-badge&labelColor=0d1117)](https://github.com)
[![Journal](https://img.shields.io/badge/Output-Q1%20Journal%20Ready-00d4ff?style=for-the-badge&labelColor=0d1117)](https://github.com)

</div>

<div align="center">

![Stata](https://img.shields.io/badge/Stata_17-1A5276?style=flat-square&logoColor=white)
![R](https://img.shields.io/badge/R_4.2+-276DC3?style=flat-square&logo=r&logoColor=white)
![NDHS](https://img.shields.io/badge/NDHS-Data-00d4ff?style=flat-square&logoColor=white)
![sf](https://img.shields.io/badge/sf-spatial-228B22?style=flat-square&logoColor=white)
![spdep](https://img.shields.io/badge/spdep-spatial%20dependence-6A0DAD?style=flat-square&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-ef4444?style=flat-square&logoColor=white)
![tidyverse](https://img.shields.io/badge/tidyverse-1a73e8?style=flat-square&logo=r&logoColor=white)
![viridis](https://img.shields.io/badge/viridis-color%20scales-10b981?style=flat-square&logoColor=white)
![patchwork](https://img.shields.io/badge/patchwork-plot%20layout-9333ea?style=flat-square&logoColor=white)

</div>

---

## Overview

This study investigates the association between **household water and handwashing facilities** and **early childhood education (ECE) participation** in Nepal, using nationally representative survey data. The analysis integrates statistical modeling with spatial visualization to identify socioeconomic and infrastructural determinants of ECE attendance among young children.

Access to clean water and handwashing facilities reflects broader household living standards and may influence children's school readiness, attendance, and educational investment by caregivers — making WASH conditions a critical yet underexplored determinant of early childhood education outcomes.

**Pipeline:**

```
Nepal DHS / National Survey Data
        │
        ▼
  Data Management        cleaning · recoding · survey weighting
    (Stata 17)           variable construction
        │
        ▼
  Statistical Analysis   logistic regression · odds ratios
    (Stata 17)           survey-weighted estimates · 95% CI
        │
        ▼
  Spatial & Descriptive  province-level choropleth maps
    Figures (R)          descriptive bar/forest plots
        │
        ▼
  Outputs                300 DPI publication-ready figures · CSV tables · maps
```

---

## Authors

**Corresponding Author**

**Md Salek Miah**
Department of Statistics
Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh
📞 +8801687831074
📧 [saleksta@gmail.com](mailto:saleksta@gmail.com)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0005--5973--461X-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0009-0005-5973-461X)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Md_Salek_Miah-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/md-salek-miah-b34309329/)

---

**Co-Authors**

**Fhameda Faija Lamia**
Department of Computer Science and Engineering
Sylhet Engineering College, Sylhet-3100, Bangladesh

**Mst. Labonna Begum**
Department of Computer Science and Engineering
Sylhet Engineering College, Sylhet-3100, Bangladesh

**Md Shied**
Computer Science
Brunel University London, United Kingdom

**Rima Akhter**
Shahabuddin Medical College, Dhaka-1212, Bangladesh

---

**Affiliation**

Biostatistics, Epidemiology, and Public Health Research Team
Department of Statistics, Shahjalal University of Science & Technology (SUST), Sylhet-3114, Bangladesh

---

## Repository Structure

```
Nepal_ECE_Analysis/
│
├── README.md
├── Analysis.do                        ← Main Stata 17 analysis script
│                                        (data management + logistic regression)
├── Data managemnt.do                  ← Stata data management & preprocessing
├── Salek.R                            ← R script for spatial & descriptive figures
└── LICENSE                            ← MIT License
```

---

## Data Source

| Dataset | Source | Description |
|:--------|:-------|:------------|
| **Nepal DHS / National Survey** | [DHS Program](https://dhsprogram.com) | Nationally Representative Cross-Sectional Survey |
| **Province Shapefile** | Nepal Admin Boundaries | Province-level spatial polygons |

> **Note:** Raw DHS microdata requires registration at [dhsprogram.com](https://dhsprogram.com). Derived/aggregated outputs in this repository are freely available for academic use.

---

## Quick Start

**Requirements:** Stata `>= 17` · R `>= 4.2`

**Step 1 — Data Management (Stata 17)**

```stata
cd "/path/to/Nepal_ECE_Analysis"
do "Data managemnt.do"
```

**Step 2 — Statistical Analysis (Stata 17)**

```stata
do Analysis.do
```

**Step 3 — Spatial & Descriptive Figures (R)**

```r
packages <- c(
  "sf",           # spatial vector data handling
  "readxl",       # read Excel files
  "dplyr",        # data manipulation
  "stringr",      # string operations
  "janitor",      # data cleaning utilities
  "ggplot2",      # core visualization
  "ggspatial",    # spatial ggplot2 extensions
  "ggtext",       # rich text in ggplot2
  "tmap",         # thematic maps
  "spdep",        # spatial dependence & autocorrelation
  "rmapshaper",   # simplify spatial geometries
  "viridis",      # accessible color scales
  "classInt",     # class interval methods
  "patchwork",    # combine multiple ggplots
  "tidyverse"     # complete data science toolkit
)

installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed], dependencies = TRUE)
}
invisible(lapply(packages, library, character.only = TRUE))

source("Salek.R")
```

---

## Key Highlights

| Feature | Details |
|:--------|:--------|
| **Exposure Variables** | Household water source · Handwashing facility availability |
| **Outcome Variable** | Early Childhood Education (ECE) participation |
| **Population** | Children of pre-primary school age in Nepal |
| **Survey Design** | Nationally representative complex survey with proper weighting |
| **Spatial Scope** | Province-level analysis across Nepal |
| **Statistical Method** | Weighted logistic regression · odds ratios · 95% CI |
| **Spatial Method** | Province-level choropleth mapping |
| **Output Format** | 300 DPI publication-ready figures |

---

## Research Impact

| Domain | Contribution |
|:-------|:-------------|
| **Early Childhood Education** | Links WASH infrastructure to ECE participation in a low-income setting |
| **Spatial Epidemiology** | Maps geographic disparities in ECE attendance across provinces |
| **Public Health** | Evidence for SDG 4 (Quality Education) & SDG 6 (Clean Water & Sanitation) |
| **Health Policy** | Actionable insights for integrated WASH and education interventions in Nepal |

---

## Citation

```bibtex
@article{miah_ece_nepal_2025,
  title   = {Household Water and Handwashing Facilities and Early Childhood
             Education Participation in Nepal: Evidence from a Nationally
             Representative Cross-Sectional Survey},
  author  = {Miah, Md Salek and Lamia, Fhameda Faija and Begum, Mst. Labonna
             and Shied, Md and Akhter, Rima},
  journal = {[Journal Name]},
  year    = {2025},
  note    = {Q1 Journal Submission},
  url     = {https://github.com/muhammadsalek/Nepal_ECE_Analysis}
}
```

---

## License

MIT License — Copyright (c) 2025 Md Salek Miah et al.
Open for academic research. Citation required for publication use.

---

<div align="center">

**Biostatistics, Epidemiology, and Public Health Research Team**
Department of Statistics · Shahjalal University of Science and Technology · Sylhet-3114, Bangladesh

[![Made with Stata](https://img.shields.io/badge/Made%20with-Stata_17-1A5276?style=flat-square&logoColor=white)](https://www.stata.com)
[![Made with R](https://img.shields.io/badge/Made%20with-R-276DC3?style=flat-square&logo=r&logoColor=white)](https://r-project.org)
[![DHS Data](https://img.shields.io/badge/Data-Nepal%20DHS-00d4ff?style=flat-square)](https://dhsprogram.com)
[![SUST](https://img.shields.io/badge/University-SUST%20Bangladesh-f59e0b?style=flat-square)](https://www.sust.edu)

*⭐ Star this repo if it helped your research!*

</div>
