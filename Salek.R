

# Install haven if not already installed
install.packages("haven")

# Load the package
library(haven)


# Install if not already installed
install.packages(c("haven", "survey", "dplyr", "pROC"))

install.packages(c("ggplot2", "plotrix"))


library(ggplot2)
library(plotrix)



# Load packages
library(haven)   # for .dta files
library(survey)  # for complex survey designs
library(dplyr)   # for data manipulation
library(pROC)    # for ROC curves




#### Import the .dta file ####
bdhs_data <- read_dta("D:/Research/BDHS Research/Nepal/Child/Data/BDHS_Nepal_Child_Clean.dta")



#### Explore ####
# View first 6 rows
head(bdhs_data)

# View last 6 rows
tail(bdhs_data)

# Get the structure of the dataset
str(bdhs_data)

# Summary statistics of all variables
summary(bdhs_data)

# View column names
colnames(bdhs_data)

# Dimensions: rows and columns
dim(bdhs_data)






#### Model ####
bdhs_data <- bdhs_data %>%
  mutate(weight = hv005 / 1000000)  # DHS weights need scaling




dhs_design <- svydesign(
  ids = ~hv021,
  strata = ~hv022,
  weights = ~weight,
  data = bdhs_data,
  nest = TRUE
)






#### Full multivariable logistic regression ####

full_model <- svyglm(ECE ~ 
                       factor(water_imp) + 
                       factor(water_treat) + 
                       factor(handwash_env) + 
                       factor(division) + 
                       hh_size + 
                       factor(mother_edu) + 
                       factor(birth_order_cat) + 
                       factor(media_access) + 
                       factor(residence) + 
                       factor(wealth) + 
                       factor(child_sex),
                     design = dhs_design,
                     family = quasibinomial())
summary(full_model)




#### Predict probabilities and ROC curve for full model####







#### Subpopulation models ####
# Rural (residence = 0)
rural_model <- svyglm(ECE ~ 
                        factor(water_imp) + 
                        factor(water_treat) + 
                        factor(handwash_env) + 
                        factor(division) + 
                        hh_size + 
                        factor(mother_edu) + 
                        factor(birth_order_cat) + 
                        factor(media_access) + 
                        factor(wealth) + 
                        factor(child_sex),
                      design = subset(dhs_design, residence == 0),
                      family = quasibinomial())

summary(rural_model)

# Make predictions safely (handling missing rows)
phat_rural <- predict(rural_model, type = "response", na.action = na.pass)
bdhs_data$phat_rural <- NA
bdhs_data$phat_rural[!is.na(model.frame(rural_model)$ECE)] <- phat_rural

roc_rural <- roc(bdhs_data$ECE[bdhs_data$residence==0], bdhs_data$phat_rural[bdhs_data$residence==0])
plot(roc_rural, col="green", main="ROC Curve - Rural Model")
auc(roc_rural)

# Urban (residence = 1)
urban_model <- svyglm(ECE ~ 
                        factor(water_imp) + 
                        factor(water_treat) + 
                        factor(handwash_env) + 
                        factor(division) + 
                        hh_size + 
                        factor(mother_edu) + 
                        factor(birth_order_cat) + 
                        factor(media_access) + 
                        factor(wealth) + 
                        factor(child_sex),
                      design = subset(dhs_design, residence == 1),
                      family = quasibinomial())

summary(urban_model)

# Make predictions safely
phat_urban <- predict(urban_model, type = "response", na.action = na.pass)
bdhs_data$phat_urban <- NA
bdhs_data$phat_urban[!is.na(model.frame(urban_model)$ECE)] <- phat_urban

roc_urban <- roc(bdhs_data$ECE[bdhs_data$residence==1], bdhs_data$phat_urban[bdhs_data$residence==1])
plot(roc_urban, col="red", main="ROC Curve - Urban Model")
auc(roc_urban)




















#### Forest Plot ####

library(broom) 





# Full model
full_model <- svyglm(ECE ~ factor(water_imp) + factor(water_treat) + factor(handwash_env) +
                       factor(division) + hh_size + factor(mother_edu) +
                       factor(birth_order_cat) + factor(media_access) +
                       factor(residence) + factor(wealth) + factor(child_sex),
                     design = dhs_design, family = quasibinomial())

# Rural model
rural_model <- svyglm(ECE ~ factor(water_imp) + factor(water_treat) + factor(handwash_env) +
                        factor(division) + hh_size + factor(mother_edu) +
                        factor(birth_order_cat) + factor(media_access) +
                        factor(wealth) + factor(child_sex),
                      design = subset(dhs_design, residence == 0),
                      family = quasibinomial())

# Urban model
urban_model <- svyglm(ECE ~ factor(water_imp) + factor(water_treat) + factor(handwash_env) +
                        factor(division) + hh_size + factor(mother_edu) +
                        factor(birth_order_cat) + factor(media_access) +
                        factor(wealth) + factor(child_sex),
                      design = subset(dhs_design, residence == 1),
                      family = quasibinomial())










# Helper function
extract_model <- function(model, model_name){
  tidy(model, conf.int = TRUE, exponentiate = TRUE) %>%
    mutate(model = model_name)
}

# Extract
full_df <- extract_model(full_model, "Full")
rural_df <- extract_model(rural_model, "Rural")
urban_df <- extract_model(urban_model, "Urban")

# Combine all models
forest_df <- bind_rows(full_df, rural_df, urban_df)

# Remove intercept for plotting
forest_df <- forest_df %>% filter(term != "(Intercept)")
















ggplot(forest_df, aes(x = term, y = estimate, ymin = conf.low, ymax = conf.high, color = model)) +
  geom_pointrange(position = position_dodge(width = 0.7), size=0.8) +
  coord_flip() +
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray") +
  labs(title = "Forest Plot: Odds Ratios for ECE (Full, Rural, Urban Models)",
       x = "Predictors",
       y = "Odds Ratio (95% CI)",
       color = "Model") +
  theme_minimal(base_size = 12) +
  theme(plot.title = element_text(hjust = 0.5))




















library(ggplot2)
library(dplyr)
library(tidyr)

# Prepare data in long format for faceting
plot_data <- bdhs_data %>%
  select(ECE, water_imp, water_treat, handwash_env) %>%
  mutate(ECE = ifelse(ECE == 1, "Yes", "No")) %>%
  pivot_longer(cols = -ECE,
               names_to = "Variable",
               values_to = "Category") %>%
  mutate(Category = as.factor(Category))

# Calculate percentages
plot_data <- plot_data %>%
  group_by(Variable, Category, ECE) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Variable) %>%
  mutate(percent = n / sum(n) * 100)

# Plot
ggplot(plot_data, aes(x = Category, y = percent, fill = ECE)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ Variable, scales = "free_x") +
  labs(title = "ECE by Water & Handwashing Indicators",
       x = "Category",
       y = "Percentage",
       fill = "ECE") +
  theme_minimal(base_size = 14) +
  theme(strip.text = element_text(face = "bold"))








library(ggplot2)
library(dplyr)
library(tidyr)
library(forcats)

# Convert 0/1 to labels
bdhs_data <- bdhs_data %>%
  mutate(
    water_imp = factor(water_imp, levels = c(0, 1), labels = c("Unimproved", "Improved")),
    water_treat = factor(water_treat, levels = c(0, 1), labels = c("No", "Yes")),
    handwash_env = factor(handwash_env, levels = c(0, 1), labels = c("Limited", "Adequate")),
    ECE = factor(ECE, levels = c(0, 1), labels = c("No", "Yes"))
  )

# Prepare data in long format
plot_data <- bdhs_data %>%
  select(ECE, water_imp, water_treat, handwash_env) %>%
  pivot_longer(cols = -ECE,
               names_to = "Variable",
               values_to = "Category")

# Calculate percentages
plot_data <- plot_data %>%
  group_by(Variable, Category, ECE) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Variable, Category) %>%
  mutate(percent = n / sum(n) * 100)

# Plot
ggplot(plot_data, aes(x = Category, y = percent, fill = ECE)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ Variable, scales = "free_x") +
  labs(title = "ECE by Water & Handwashing Indicators",
       x = "Category",
       y = "Percentage",
       fill = "ECE") +
  theme_minimal(base_size = 14) +
  theme(strip.text = element_text(face = "bold"))








# Updated Plot
ggplot(plot_data, aes(x = Category, y = percent, fill = ECE)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~ Variable, scales = "free_x") +
  labs(title = "ECE by Water & Handwashing Indicators",
       x = "Category",
       y = "Percentage",
       fill = "ECE") +
  scale_fill_manual(values = c("No" = "#FF9999", "Yes" = "#66CC99")) +  # bright colors
  theme_minimal(base_size = 14) +
  theme(
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_blank()
  )








# Enhanced Plot
ggplot(plot_data, aes(x = Category, y = percent, fill = ECE)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), color = "black", width = 0.7) +
  geom_text(aes(label = sprintf("%.1f%%", percent)),
            position = position_dodge(width = 0.8),
            vjust = -0.5, size = 3.5, fontface = "bold") +
  facet_wrap(~ Variable, scales = "free_x") +
  labs(title = "ECE by Water & Handwashing Indicators",
       x = "Category",
       y = "Percentage",
       fill = "ECE") +
  scale_fill_manual(values = c("No" = "#FF9999", "Yes" = "#66CC99")) +  # bright, clean colors
  theme_minimal(base_size = 14) +
  theme(
    strip.text = element_text(face = "bold", size = 13),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
    axis.title = element_text(face = "bold"),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_blank(),
    legend.position = "top",
    legend.title = element_text(face = "bold")
  )








library(dplyr)
library(plotly)

# Prepare data: count by ECE and water_imp
pie_data <- bdhs_data %>%
  select(ECE, water_imp) %>%
  mutate(
    ECE = factor(ECE, levels = c(0,1), labels = c("No","Yes")),
    water_imp = factor(water_imp, levels = c(0,1), labels = c("Unimproved", "Improved"))
  ) %>%
  drop_na() %>%
  group_by(water_imp, ECE) %>%
  summarise(n = n(), .groups = "drop") %>%
  mutate(percent = n / sum(n) * 100)

# Create 3D Pie Chart using plotly
plot_ly(pie_data, labels = ~ECE, values = ~percent, type = 'pie', textinfo = 'label+percent',
        hole = 0.3, pull = 0.05,
        marker = list(colors = c("#FF9999", "#66CC99"),
                      line = list(color = '#FFFFFF', width = 2))) %>%
  layout(title = 'ECE Distribution by Water Improvement',
         showlegend = TRUE)








#### Spatial ####



#### Vector of package names####
packages <- c(
  "readxl",      # Read Excel files
  "sf",          # Handle shapefiles
  "dplyr",       # Data manipulation
  "tmap",        # Thematic mapping
  "ggplot2",     # High-quality plots
  "ggthemes",    # Themes for ggplot2
  "viridis",     # Color scales
  "RColorBrewer" # More palettes
)

# Install all packages at once
install.packages(packages)

# Load all packages
lapply(packages, library, character.only = TRUE)






# Load libraries
library(readxl)
library(sf)
library(dplyr)
library(tmap)
library(ggplot2)
library(ggthemes)
library(viridis)
library(RColorBrewer)








# Load required packages
library(readxl)
library(sf)
library(dplyr)





############################################################
# Load required packages
############################################################
library(sf)
library(readxl)
library(dplyr)
library(stringdist)
library(ggplot2)

############################################################
# File paths
############################################################
shp_path <- "D:/Research/BDHS Research/Nepal/SBA/Spatial/data/npl_adm_nd_20240314_ab_shp/npl_admbnda_adm1_nd_20240314.shp"
excel_path <- "D:/Research/BDHS Research/Nepal/Child/Data/ECE_division_pct.xlsx"

############################################################
# 1. Read shapefile (Province level)
############################################################
nepal_shp <- st_read(shp_path)

# Check province name variable
names(nepal_shp)

############################################################
# 2. Read ECE Excel data
############################################################
ece_div <- read_excel(excel_path)

# Check variables
str(ece_div)







############################################################
# File paths
############################################################
excel_file <- "D:/Research/BDHS Research/Nepal/Child/Data/ECE_division_pct.xlsx"
shp_file   <- "D:/Research/BDHS Research/Nepal/SBA/Spatial/data/npl_adm_nd_20240314_ab_shp/npl_admbnda_adm1_nd_20240314.shp"

############################################################
# Libraries
############################################################
library(sf)
library(readxl)
library(dplyr)
library(ggplot2)
library(ggspatial)
library(grid)

############################################################
# Read shapefile
############################################################
nepal_shp <- st_read(shp_file)
head(nepal_shp)
names(nepal_shp)

############################################################
# Read Excel data
############################################################
ece_data <- read_excel(excel_file)
head(ece_data)




############################################################
# Preprocessing
############################################################

# Convert to lowercase for consistency
ece_data$province <- tolower(ece_data$division)
nepal_shp$adm1_name <- tolower(nepal_shp$ADM1_EN)



############################################################
# Check for mismatches
############################################################
setdiff(ece_data$province, nepal_shp$adm1_name)

############################################################
# Fix known spelling issues (Nepal-specific)
############################################################

############################################################
# Fix known spelling issues (Nepal-specific) – CORRECT
############################################################
ece_data$province[ece_data$province == "sudurpashchim"] <- "sudurpashchim"
ece_data$province[ece_data$province == "madesh"]        <- "madhesh"



############################################################
# Robust Nepal province name harmonization
############################################################
ece_data$province <- dplyr::case_when(
  ece_data$province %in% c("sudurpaschim", "sudurpashchim") ~ "sudurpashchim",
  ece_data$province == "madesh"                              ~ "madhesh",
  TRUE                                                       ~ ece_data$province
)

setdiff(ece_data$province, nepal_shp$adm1_name)




sort(unique(nepal_shp$adm1_name))



############################################################
# Final Nepal province name harmonization (SPACE issue)
############################################################
ece_data$province <- dplyr::case_when(
  ece_data$province %in% c("sudurpashchim", "sudurpaschim") ~ "sudur paschim",
  ece_data$province == "madesh"                              ~ "madhesh",
  TRUE                                                       ~ ece_data$province
)

setdiff(ece_data$province, nepal_shp$adm1_name)



############################################################
# Merge spatial + ECE data
############################################################
nepal_map <- merge(
  nepal_shp,
  ece_data,
  by.x = "adm1_name",
  by.y = "province",
  all.x = TRUE
)

############################################################
# Visualization
############################################################

# Shadow behind map
shadow_map <- st_buffer(st_union(nepal_map), dist = 0.15)

ggplot() +
  # Shadow
  geom_sf(data = shadow_map, fill = "grey92", color = NA) +
  
  # Map polygons
  geom_sf(
    data = nepal_map,
    aes(fill = pct_yes),
    color = "white",
    linewidth = 0.35
  ) +
  
  # Color gradient
  scale_fill_gradient(
    low = "lightyellow",
    high = "darkred",
    name = "ECE (%)"
  ) +
  
  # Province labels
  geom_sf_text(
    data = nepal_map,
    aes(label = ADM1_EN),
    size = 3,
    fontface = "bold",
    color = "black",
    check_overlap = TRUE
  ) +
  
  # North arrow
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    style = north_arrow_fancy_orienteering,
    height = unit(1, "cm"),
    width = unit(1, "cm")
  ) +
  
  # Scale bar
  annotation_scale(
    location = "bl",
    width_hint = 0.25,
    text_cex = 0.8
  ) +
  
  coord_sf(expand = FALSE) +
  
  theme_minimal() +
  theme(
    plot.margin = margin(15, 15, 15, 15),
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 3
    ),
    
    legend.position = c(0.65, 0.18),
    legend.justification = c(0, 0),
    legend.background = element_rect(
      fill = "white",
      color = "black",
      linewidth = 0.8
    ),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text  = element_text(size = 9),
    
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.2),
    
    axis.text = element_text(size = 8, color = "black")
  ) +
  
  labs(
    title = "Province-wise Early Childhood Education (ECE) in Nepal",
    subtitle = "Distribution of ECE participation (Yes = 1)",
    x = "Longitude",
    y = "Latitude",
    caption = "Source: BDHS Nepal | ADM1 boundaries"
  )















# Shadow behind map
shadow_map <- st_buffer(st_union(nepal_map), dist = 0.15)

ggplot() +
  # Shadow
  geom_sf(data = shadow_map, fill = "grey92", color = NA) +
  
  # Map polygons
  geom_sf(
    data = nepal_map,
    aes(fill = pct_yes),
    color = "white",
    linewidth = 0.35
  ) +
  
  # Color gradient
  scale_fill_gradient(
    low = "lightyellow",
    high = "darkred",
    name = "ECE (%)"
  ) +
  
  # Province labels
  geom_sf_text(
    data = nepal_map,
    aes(label = ADM1_EN),
    size = 3,
    fontface = "bold",
    color = "black",
    check_overlap = TRUE
  ) +
  
  # North arrow
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    style = north_arrow_fancy_orienteering,
    height = unit(1, "cm"),
    width = unit(1, "cm")
  ) +
  
  # Scale bar
  annotation_scale(
    location = "bl",
    width_hint = 0.25,
    text_cex = 0.8
  ) +
  
  coord_sf(expand = FALSE) +
  
  theme_minimal() +
  theme(
    plot.margin = margin(15, 15, 15, 15),
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 3
    ),
    
    # Legend slightly above map
    legend.position = c(0.10, 0.15),   # x=0.5 centers horizontally, y=1.02 slightly above plot
    legend.justification = c(0.5, 0), # center alignment
    legend.background = element_rect(
      fill = "white",
      color = "black",
      linewidth = 0.8
    ),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text  = element_text(size = 9),
    
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.2),
    
    axis.text = element_text(size = 8, color = "black")
  ) +
  
  labs(
    title = "Province-wise Early Childhood Education (ECE) in Nepal",
    subtitle = "Distribution of ECE participation (Yes = 1)",
    x = "Longitude",
    y = "Latitude",
    caption = "Source: BDHS Nepal | ADM1 boundaries"
  )





# Shadow behind map
shadow_map <- st_buffer(st_union(nepal_map), dist = 0.15)

ggplot() +
  # Shadow
  geom_sf(data = shadow_map, fill = "grey92", color = NA) +
  
  # Map polygons
  geom_sf(
    data = nepal_map,
    aes(fill = pct_yes),
    color = "white",
    linewidth = 0.35
  ) +
  
  # Color gradient (alternative)
  scale_fill_gradient(
    low = "lightblue",
    high = "darkgreen",
    name = "ECE (%)"
  ) +
  
  # Province labels
  geom_sf_text(
    data = nepal_map,
    aes(label = ADM1_EN),
    size = 3,
    fontface = "bold",
    color = "black",
    check_overlap = TRUE
  ) +
  
  # North arrow
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    style = north_arrow_fancy_orienteering,
    height = unit(1, "cm"),
    width = unit(1, "cm")
  ) +
  
  # Scale bar
  annotation_scale(
    location = "bl",
    width_hint = 0.25,
    text_cex = 0.8
  ) +
  
  coord_sf(expand = FALSE) +
  
  theme_minimal() +
  theme(
    plot.margin = margin(15, 15, 15, 15),
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 3
    ),
    
    # Legend slightly above map
    legend.position = c(0.10, 0.15),
    legend.justification = c(0.5, 0),
    legend.background = element_rect(
      fill = "white",
      color = "black",
      linewidth = 0.8
    ),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text  = element_text(size = 9),
    
    panel.grid.major = element_line(color = "grey90", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.2),
    
    axis.text = element_text(size = 8, color = "black")
  ) +
  
  labs(
    title = "Province-wise Early Childhood Education (ECE) in Nepal",
    subtitle = "Distribution of ECE participation (Yes = 1)",
    x = "Longitude",
    y = "Latitude",
    caption = "Source: BDHS Nepal | ADM1 boundaries"
  )












