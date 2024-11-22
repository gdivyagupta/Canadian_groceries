file_path <- "data/dataset.csv"  
data <- read.csv(file_path)

# Install the necessary libraries 
install.packages("ggplot2")
install.packages("dplyr")

# Load libraries
library(ggplot2)
library(dplyr)

# Visual 1 - Vendor Distribution 

# Group by vendor and count products, then filter for top 10 vendors
vendor_distribution <- data |>
  group_by(vendor) |>
  summarise(product_count = n()) |>
  arrange(desc(product_count)) |>
  slice_head(n = 10)

# Bar plot for top 10 vendors
ggplot(vendor_distribution, aes(x = reorder(vendor, -product_count), y = product_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Top 10 Vendors by Product Count", x = "Vendor", y = "Product Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Visual 2 - Brand Distrubution 

# Group by brand and count products, then filter for top 10 brands
brand_distribution <- data |>
  filter(!is.na(brand)) |>
  group_by(brand) |>
  summarise(brand_count = n()) |>
  arrange(desc(brand_count)) |>
  slice_head(n = 10)

# Bar plot for top 10 brands
ggplot(brand_distribution, aes(x = reorder(brand, -brand_count), y = brand_count)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Top 10 Brands by Product Count", x = "Brand", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# General Summ Stats
numeric_stats <- data |>
  select_if(is.numeric) |>
  summarise(
    across(everything(), list(
      mean = ~mean(. , na.rm = TRUE),
      median = ~median(. , na.rm = TRUE),
      sd = ~sd(. , na.rm = TRUE)
    ))
  )
cat("\nNumeric summary statistics (mean, median, sd):\n")
print(numeric_stats)
