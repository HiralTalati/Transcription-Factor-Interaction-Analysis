#script for TF degree after using NetworkAnalyst3.2, ENCODE, TF-Gene interaction:

###############################################################
## TF RANKING FROM NETWORKANALYST (ENCODE)
###############################################################

library(readr)
library(dplyr)
library(ggplot2)
library(stringr)

###############################################################
## READ NETWORK
###############################################################

network <- read.csv(
  "TF activity/network_tf.csv",
  stringsAsFactors = FALSE
)

head(network)
colnames(network)

###############################################################
## KEEP ONLY TF-GENE EDGES
###############################################################

# Name1 = Hub Gene
# Name2 = TF

network <- network %>%
  distinct(Name1, Name2)

###############################################################
## CALCULATE TF DEGREE
###############################################################

tf_rank <- network %>%
  group_by(Name2) %>%
  summarise(
    
    Degree = n(),
    
    Hub_Genes = paste(
      sort(unique(Name1)),
      collapse = ", "
    )
    
  ) %>%
  arrange(desc(Degree))

###############################################################
## RENAME COLUMNS
###############################################################

colnames(tf_rank) <- c(
  "Transcription_Factor",
  "Degree",
  "Hub_Genes_Regulated"
)

###############################################################
## DISPLAY
###############################################################

print(tf_rank)

###############################################################
## SAVE COMPLETE TABLE
###############################################################

write.csv(
  tf_rank,
  "TF_Ranking_Table.csv",
  row.names = FALSE
)

###############################################################
## TOP 15 TFs
###############################################################

top20 <- tf_rank %>%
  slice(1:20)

print(top20)

write.csv(
  top20,
  "Top20_TFs.csv",
  row.names = FALSE
)

###############################################################
## BARPLOT
###############################################################

ggplot(
  top20,
  aes(
    x = reorder(
      Transcription_Factor,
      Degree
    ),
    y = Degree
  )
) +
  
  geom_col(
    fill = "#2C7FB8",
    width = 0.7
  ) +
  
  coord_flip() +
  
  theme_classic(base_size = 14) +
  
  labs(
    
    title = "Top Transcription Factors Regulating Hub Genes",
    
    x = "Transcription Factor",
    
    y = "Number of Hub Genes Regulated"
    
  )

ggsave(
  
  "Top20_TF_Barplot.png",
  
  width = 7,
  
  height = 5,
  
  dpi = 600
  
)

###############################################################
## EXPORT NETWORK OF TOP TFs
###############################################################

top_network <- network %>%
  filter(
    Name2 %in%
      top20$Transcription_Factor
  )

write.csv(
  
  top_network,
  
  "Top20_TF_Network.csv",
  
  row.names = FALSE
  
)

###############################################################
## HUB GENE COVERAGE
###############################################################

gene_summary <- network %>%
  group_by(Name1) %>%
  summarise(
    
    Number_of_TFs = n(),
    
    TFs = paste(
      sort(unique(Name2)),
      collapse = ", "
    )
    
  ) %>%
  arrange(desc(Number_of_TFs))

write.csv(
  
  gene_summary,
  
  "HubGene_TF_Summary20.csv",
  
  row.names = FALSE
  
)

print(gene_summary)
