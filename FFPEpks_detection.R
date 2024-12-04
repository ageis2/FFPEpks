library(tidyverse)
library(janitor)
library(ggplot2)
getwd()

pksFFPE <- read_csv("20231109_DNA from FFPE pilot_mouse colon.csv")
pksFFPE <- remove_empty(c("rows", "cols"))

cols_to_replace <- c("Ec_Ct Undiluted", "pks_Ct Diluted", "pks_Ct Undiluted")

pksFFPE <- pksFFPE %>%
  mutate(across(all_of(cols_to_replace), ~ replace(., . == "ND", 40))) %>%
  mutate(across(all_of(cols_to_replace), as.numeric))

new_df <- pksFFPE %>%
  mutate(genotype_inoculation = paste(pksFFPE$genotype, pksFFPE$inoculation_status, sep = "_"),
         EcopyN_ngDNA = )

new_df <- new_df %>%
  replace(`pks_Ct Diluted`, 'ND', 40)

ggplot(new_df, aes(x=genotype_inoculation, y='Ec_Ct Diluted')) + 
  geom_point() +
  labs(y= "Ec_Ct Diluted")
