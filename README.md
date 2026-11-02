# Nepal Early Childhood Education (ECE) Analysis

## Household Water and Handwashing Facilities and Early Childhood Education Participation in Nepal: Evidence from a Nationally Representative Cross-Sectional Survey

<div align="center">

[![DOI](https://img.shields.io/badge/DOI-10.1002%2Fhsr2.72254-FF6B35?style=for-the-badge&labelColor=0d1117&logo=doi&logoColor=FF6B35)](https://doi.org/10.1002/hsr2.72254)
[![Journal](https://img.shields.io/badge/Health_Science_Reports-Published_April_2026-10b981?style=for-the-badge&labelColor=0d1117)](https://onlinelibrary.wiley.com/doi/10.1002/hsr2.72254)
[![License](https://img.shields.io/badge/License-MIT-7c3aed?style=for-the-badge&labelColor=0d1117&logo=opensourceinitiative&logoColor=7c3aed)](LICENSE)

</div>

<div align="center">

![Stata](https://img.shields.io/badge/Stata_17-1A5276?style=flat-square&logoColor=white)
![R](https://img.shields.io/badge/R_4.5.1-276DC3?style=flat-square&logo=r&logoColor=white)
![NDHS](https://img.shields.io/badge/NDHS_2022-00d4ff?style=flat-square&logoColor=white)
![OpenAccess](https://img.shields.io/badge/Open_Access-CC_BY-f59e0b?style=flat-square&logo=creativecommons&logoColor=white)
![sf](https://img.shields.io/badge/sf-spatial-228B22?style=flat-square&logoColor=white)
![spdep](https://img.shields.io/badge/spdep-spatial%20dependence-6A0DAD?style=flat-square&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-ef4444?style=flat-square&logoColor=white)
![tidyverse](https://img.shields.io/badge/tidyverse-1a73e8?style=flat-square&logo=r&logoColor=white)
![viridis](https://img.shields.io/badge/viridis-color%20scales-10b981?style=flat-square&logoColor=white)
![patchwork](https://img.shields.io/badge/patchwork-plot%20layout-9333ea?style=flat-square&logoColor=white)

</div>

---

> **📢 This paper has been peer-reviewed and published in *Health Science Reports* (Wiley), April 2026.**
> 
> **Full text:** [https://doi.org/10.1002/hsr2.72254](https://doi.org/10.1002/hsr2.72254)

---

## Publication Details

| Field | Information |
|:------|:-----------|
| **Journal** | *Health Science Reports* |
| **Publisher** | Wiley Periodicals LLC |
| **Article ID** | e72254 |
| **DOI** | [10.1002/hsr2.72254](https://doi.org/10.1002/hsr2.72254) |
| **Volume / Issue** | 9 / 4 (April 2026) |
| **Article Type** | Original Research |
| **Access Type** | Open Access (CC BY) |
| **Received** | 17 December 2025 |
| **Revised** | 18 March 2026 |
| **Accepted** | 25 March 2026 |
| **Published** | April 2026 |
| **Keywords** | ECE · LMICs · spatial · stratified · WASH |

---

## Overview

This study investigates the association between **household water and handwashing facilities** and **early childhood education (ECE) participation** in Nepal, using the nationally representative **Nepal Demographic and Health Survey (NDHS) 2022**. The analysis integrates survey-weighted statistical modeling with spatial visualization to identify socioeconomic and infrastructural determinants of ECE attendance among children aged **3–4 years** (n = 1,057).

Access to clean water and handwashing facilities reflects broader household living standards and may influence children's school readiness, attendance, and educational investment by caregivers — making WASH conditions a critical yet underexplored determinant of early childhood education outcomes in low- and middle-income country (LMIC) settings.

### Key Findings at a Glance

| Finding | Detail |
|:--------|:-------|
| **ECE Enrollment Rate** | 78.7% of children in the analytical sample |
| **Strongest Predictor** | Media access (AOR = 5.17; 95% CI: 2.04–13.10) |
| **Urban Wealth Effect** | Richer households had 2.61× higher ECE odds (AOR = 2.61; 95% CI: 1.04–6.52) |
| **Rural Residence** | Associated with reduced ECE odds (AOR = 0.51; 95% CI: 0.28–0.92) |
| **Model Performance** | Excellent discrimination (AUC = 0.957) |
| **Provincial Variation** | Karnali & Koshi highest; Gandaki lowest enrollment |
| **WASH Conclusion** | WASH effects attenuated after socioeconomic adjustment |

---

## Abstract

**Background and Aims:** Early childhood education (ECE) is crucial for cognitive, social, and emotional development. Household water, sanitation, and hygiene (WASH) may influence ECE enrollment, but their role in Nepal is unclear. This study examined associations between household water and handwashing facilities and ECE participation among children aged 3–4 years, accounting for rural–urban and socioeconomic factors.

**Methods:** This cross-sectional study used nationally representative secondary data from the Nepal Demographic and Health Survey (NDHS) 2022, including 1,057 children aged 3–4 years. Descriptive analyses, survey-weighted multivariable logistic regression, and stratified analyses were employed according to rural–urban residence. Additionally, spatial mapping was used to examine geographical variation in ECE participation. Model performance was evaluated using receiver operating characteristic (ROC) curve analysis and the area under the curve (AUC). All results were reported as adjusted odds ratios (AORs) with 95% confidence intervals (CIs).

**Results:** Overall, 78.7% of children participated in ECE. Improved water sources, treated water, and handwashing facilities were associated with higher enrollment in bivariate analyses. After adjustment, household media access (AOR: 5.17; 95% CI: 2.04–13.10) and urban wealth (AOR: 2.61; 95% CI: 1.04–6.52) remained significant. The predictive model showed excellent discrimination (AUC = 0.957). Provincial disparities existed, with Karnali and Koshi higher and Gandaki lower.

**Conclusion:** Media contact drives ECE enrollment, whereas WASH effects appear attenuated after accounting for socioeconomic and maternal factors. Improving maternal education and media-based awareness may enhance ECE participation, especially in rural areas.

---

## Analysis Pipeline

```
Nepal DHS 2022 Raw Microdata (N = 57,278)
        │
        ▼  Age eligibility (3–4 yrs): N = 2,178
  Data Management        cleaning · recoding · de jure restriction
    (Stata 17)           variable construction · survey weighting
        │
        ▼  Final analytical sample: N = 1,057
  Statistical Analysis   survey-weighted logistic regression
    (Stata 17)           crude & adjusted ORs · 95% CI · ROC/AUC
                         rural–urban stratified models
        │
        ▼
  Spatial & Descriptive  province-level choropleth maps (7 provinces)
    Figures (R 4.5.1)    descriptive bar plots · forest plots
                         Moran's I · spatial autocorrelation
        │
        ▼
  Outputs                300 DPI publication-ready figures
                         CSV result tables · shapefiles · maps
```

---

## Authors

### Corresponding Author

**Md Salek Miah**  
Department of Statistics  
Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh  
📞 +8801687831074  
📧 [saleksta@gmail.com](mailto:saleksta@gmail.com)  

[![ORCID](https://img.shields.io/badge/ORCID-0009--0005--5973--461X-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0009-0005-5973-461X)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Md_Salek_Miah-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/md-salek-miah-b34309329/)

---

### Co-Authors

| Author | Affiliation | Role |
|:-------|:-----------|:-----|
| **Fhameda Faija Lamia** | Department of Computer Science and Engineering, Sylhet Engineering College, Sylhet-3100, Bangladesh | Writing & Literature Review |
| **Mst. Labonna Begum** | Department of Computer Science and Engineering, Sylhet Engineering College, Sylhet-3100, Bangladesh | Writing & Literature Review |
| **Md Shied** | Computer Science, Brunel University London, United Kingdom | Writing & Literature Review |
| **Rima Akhter** | Shahabuddin Medical College, Dhaka-1212, Bangladesh; School of Public Health, University of Saskatchewan, Saskatoon, Canada | Supervision, Review & Validation |

---

### Research Group

**Biostatistics, Epidemiology, and Public Health Research Team**  
Department of Statistics, Shahjalal University of Science & Technology (SUST), Sylhet-3114, Bangladesh

---

## Repository Structure

```
Nepal_ECE_Analysis/
│
├── README.md                          ← This file
├── Analysis.do                        ← Main Stata 17 analysis script
│                                        (survey-weighted logistic regression,
│                                         crude & adjusted ORs, ROC/AUC, stratified models)
├── Data management.do                  ← Stata data management & preprocessing
│                                        (cleaning, recoding, de jure restriction,
│                                         WASH variable construction, survey setup)
├── Salek.R                            ← R script (v4.5.1) for all figures:
│                                        province choropleth maps, bar charts,
│                                        forest plots, spatial autocorrelation
└── LICENSE                            ← MIT License
```

---

## Data Source

| Dataset | Source | Description |
|:--------|:-------|:------------|
| **Nepal Demographic and Health Survey 2022** | [DHS Program](https://dhsprogram.com) | Nationally representative cross-sectional survey; stratified two-stage cluster sampling; all 7 provinces |
| **Nepal Province Shapefile** | Nepal Admin Boundaries | Province-level spatial polygons for choropleth mapping |

> **Note:** Raw DHS microdata requires free registration at [dhsprogram.com](https://dhsprogram.com). All derived/aggregated outputs and code in this repository are freely available for academic use under the MIT License.

---

## Quick Start

**Requirements:** Stata `≥ 17` · R `≥ 4.2` (tested on R 4.5.1)

### Step 1 — Data Management (Stata 17)

```stata
* Set working directory
cd "/path/to/Nepal_ECE_Analysis"

* Run data cleaning, recoding, and variable construction
* Applies de jure restriction, handles missing data, constructs WASH composites
do "Data management.do"
```

### Step 2 — Statistical Analysis (Stata 17)

```stata
* Runs survey-weighted logistic regression (crude + adjusted)
* Produces stratified models (rural/urban), ROC/AUC, Hosmer-Lemeshow test
* Exports coefficient tables to CSV
do "Analysis.do"
```

### Step 3 — Spatial & Descriptive Figures (R 4.5.1)

```r
# Install required packages (if not already installed)
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
  "spdep",        # spatial dependence & autocorrelation (Moran's I)
  "rmapshaper",   # simplify spatial geometries
  "viridis",      # accessible color scales
  "classInt",     # class interval methods (Jenks/quantile breaks)
  "patchwork",    # combine multiple ggplots
  "tidyverse"     # complete data science toolkit
)

installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed], dependencies = TRUE)
}
invisible(lapply(packages, library, character.only = TRUE))

# Generate all figures (choropleth maps, bar charts, forest plots)
source("Salek.R")
```

---

## Methods Summary

| Component | Detail |
|:----------|:-------|
| **Study Design** | Cross-sectional, secondary data analysis |
| **Data Source** | Nepal Demographic and Health Survey (NDHS) 2022 |
| **Sample** | 1,057 children aged 3–4 years (de jure residents) |
| **Outcome** | ECE participation (DHS variable `hv121`; binary: Yes/No) |
| **Primary Exposure** | Household handwashing environment (WHO/UNICEF JMP definition) |
| **Other WASH Variables** | Drinking water source (improved/unimproved); water treatment (treated/untreated) |
| **Covariates** | Child sex, birth order; maternal education; household size, sex of head, wealth index, media access; residence (rural/urban); province |
| **Statistical Method** | Survey-weighted multivariable logistic regression (crude & adjusted ORs, 95% CI) |
| **Stratified Analysis** | Separate models for rural (n = 548) and urban (n = 508) subgroups |
| **Spatial Method** | Province-level choropleth mapping; Moran's I spatial autocorrelation |
| **Model Diagnostics** | ROC/AUC curve (AUC = 0.957); Hosmer–Lemeshow goodness-of-fit; VIF < 10 |
| **Missing Data** | Complete-case analysis; sensitivity analysis conducted |
| **Reporting Standard** | STROBE guidelines; SAMPL reporting guidelines |
| **Software** | Stata 17; R 4.5.1 |

---

## Key Results

### ECE Enrollment by WASH Indicators

| WASH Indicator | ECE = Yes | ECE = No | p-value |
|:--------------|:---------|:---------|:-------|
| Improved water source | 74.9% | 21.0% | 0.019 |
| Treated drinking water | 20.7% | 1.3% (Yes); 58.0% vs 20.0% (No) | < 0.001 |
| Basic handwashing facility | 70.7% | 17.6% | 0.003 |
| Fixed handwashing place | 73.0% | 17.6% | < 0.001 |
| Adequate handwashing environment | 69.7% | 16.5% | < 0.001 |

### Adjusted Odds Ratios — Final Multivariable Model (n = 1,057)

| Predictor | AOR | 95% CI | p-value |
|:----------|:----|:-------|:-------|
| Media access (has access vs. none) | **5.17** | 2.04–13.10 | 0.001 |
| Wealth — Richer vs. Poorest | **2.61** | 1.04–6.52 | 0.040 |
| Residence — Rural vs. Urban | **0.51** | 0.28–0.92 | 0.027 |
| Province — Madhesh vs. Koshi | **0.29** | 0.12–0.71 | 0.007 |
| WASH variables | Attenuated | — | NS after adjustment |

### Stratified Results (Rural vs. Urban)

| Predictor | Rural AOR (95% CI) | p | Urban AOR (95% CI) | p |
|:----------|:------------------|:--|:------------------|:--|
| Media access | 3.84 (1.27–11.60) | 0.017 | 6.25 (1.75–22.28) | 0.005 |
| Wealth — Poorer | 0.41 (0.12–1.45) | 0.167 | 6.55 (1.57–27.42) | 0.010 |
| Wealth — Middle | 1.32 (0.39–4.43) | 0.649 | 6.43 (1.42–29.20) | 0.016 |
| Wealth — Richer | 1.18 (0.28–4.99) | 0.817 | 8.73 (2.01–37.95) | 0.004 |

---

## Research Impact

| Domain | Contribution |
|:-------|:-------------|
| **Early Childhood Education** | First nationally representative analysis linking WASH infrastructure to ECE participation in Nepal using NDHS 2022 |
| **Spatial Epidemiology** | Province-level choropleth mapping revealing geographic disparities across all 7 provinces of Nepal |
| **Public Health** | Evidence base for SDG 4.2 (universal quality ECE) and SDG 6 (clean water and sanitation) |
| **Health Policy** | Demonstrates media access as the dominant modifiable predictor of ECE; supports integrated WASH + education interventions |
| **Methodology** | Survey-weighted stratified logistic regression with spatial analysis; excellent model discrimination (AUC = 0.957) |

---

## Policy Recommendations

1. **Media-based awareness campaigns** — strongest predictor across both rural and urban settings (AOR = 5.17); community-based and digital outreach to improve parental awareness of ECE benefits
2. **Urban ECE subsidies** — wealth inequality in ECE participation is stronger in urban areas; targeted financial support for lower-income urban households
3. **Geographically targeted programs** — Gandaki province needs specific resource allocation given lowest ECE participation levels
4. **Integrated WASH + education interventions** — while WASH effects are attenuated post-adjustment, continued WASH investment supports child health that enables educational readiness
5. **Maternal education investment** — theoretically important predictor; future surveys should minimize missing data on maternal education

---

## Citation

If you use this code or findings in your research, please cite the published paper:

```bibtex
@article{miah_ece_nepal_2026,
  title     = {Household Water and Handwashing Facilities and Early Childhood
               Education Participation in Nepal: Evidence From a Nationally
               Representative Cross-Sectional Survey},
  author    = {Miah, Md Salek and Lamia, Fhameda Faija and Begum, Mst. Labonna
               and Shied, Md and Akhter, Rima},
  journal   = {Health Science Reports},
  volume    = {9},
  number    = {4},
  pages     = {e72254},
  year      = {2026},
  publisher = {Wiley Periodicals LLC},
  doi       = {10.1002/hsr2.72254},
  url       = {https://doi.org/10.1002/hsr2.72254},
  note      = {Open Access, CC BY License}
}
```

---

## Ethical Statement

The data used in this study were derived from the Nepal Demographic and Health Survey 2022, which received ethical approval from the **Nepal Health Research Council (NHRC)** and the **Institutional Review Board (IRB)** of the implementing organization. Written informed consent was obtained from all adult participants and from parents/legal guardians on behalf of participating children. DHS data privacy policy: [dhsprogram.com/Methodology/Protecting-the-Privacy-of-DHS-Survey-Respondents.cfm](https://dhsprogram.com/Methodology/Protecting-the-Privacy-of-DHS-Survey-Respondents.cfm)

---

## Data Availability

- **Raw microdata:** Publicly available from the DHS Program upon free registration at [dhsprogram.com/data](https://dhsprogram.com/data)
- **Analysis code:** Fully available in this repository (MIT License)
- **Aggregated outputs:** Available in this repository for academic use

---

## Funding & Conflicts of Interest

This research received no specific funding. The authors declare no conflicts of interest.

---

## AI Use Declaration

The authors utilized generative AI tools (Grammarly, QuillBot, ChatGPT GPT-4) solely for language correction and writing clarity. No AI tools were used for data collection, analysis, interpretation, or figure generation.

---

## License

MIT License — Copyright © 2026 Md Salek Miah et al.  
Open for academic research and replication. **Citation of the published article required for any publication use.**

---

<div align="center">

**Biostatistics, Epidemiology, and Public Health Research Team**  
Department of Statistics · Shahjalal University of Science and Technology · Sylhet-3114, Bangladesh

[![Published in HSR](https://img.shields.io/badge/Published-Health_Science_Reports_2026-FF6B35?style=flat-square)](https://doi.org/10.1002/hsr2.72254)
[![DOI](https://img.shields.io/badge/DOI-10.1002%2Fhsr2.72254-FF6B35?style=flat-square)](https://doi.org/10.1002/hsr2.72254)
[![Made with Stata](https://img.shields.io/badge/Made%20with-Stata_17-1A5276?style=flat-square)](https://www.stata.com)
[![Made with R](https://img.shields.io/badge/Made%20with-R_4.5.1-276DC3?style=flat-square&logo=r)](https://r-project.org)
[![DHS Data](https://img.shields.io/badge/Data-Nepal_DHS_2022-00d4ff?style=flat-square)](https://dhsprogram.com)
[![SUST](https://img.shields.io/badge/University-SUST%20Bangladesh-f59e0b?style=flat-square)](https://www.sust.edu)
[![Open Access](https://img.shields.io/badge/Open_Access-CC_BY-f59e0b?style=flat-square&logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)

*⭐ Star this repo if it helped your research! Please cite the published article.*

</div>
