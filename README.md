**Transcription Factor (TF) Network Analyst & Ranking Pipeline**

This repository contains an R-based bioinformatics script designed to parse, clean, and analyze Transcription Factor (TF)-Gene interaction networks. The pipeline is tailored for downstream processing of network topology exported from platforms like NetworkAnalyst 3.2 (utilizing the ENCODE database). It calculates the connectivity degree of TFs regulating specific hub genes, isolates top-tier regulators, and exports structured edge lists for cytoscape/network visualization.

📌 Features

• Edge-List De-duplication: Filters raw network tables to ensure unique directed interaction edges between targeted Hub Genes (Name1) and candidate Transcription Factors (Name2).

• TF Topology & Degree Calculation: Computes the true network degree of each TF by aggregating the total number of distinct hub genes it regulates.

• Hub-Gene Mapping Collapse: Generates a collapsed, comma-separated array string listing the exact collection of hub nodes governed by each specific factor.

• Gene-Centric Coverage Profiling: Computes inverse network mappings to reveal how many TFs target each independent hub gene, identifying heavily guarded genomic nodes.

• Sub-Network Subsetting: Automatically extracts and subsets a localized edge network containing exclusively the top 20 most influential TFs for seamless import into tools like Cytoscape.

🛠️ Tech Stack & Dependencies

The computational pipeline runs natively inside an R environment (v4.0+).

Required Packages:

Ensure you have the following packages installed in your active R instance:

install.packages(c("readr", "dplyr", "ggplot2", "stringr"))

📂 Input Configurations & Dataset Requirements

The pipeline operates on a tabular edge-list CSV file from network analysis tools.

Expected Columns in Raw File:

• Name1: Hugo Gene Nomenclature Symbol corresponding to the target Hub Gene.

• Name2: Gene/Protein symbol identifying the binding Transcription Factor (TF).

Note: Ensure to update the file path in the read.csv() line of your local script to point toward your actual workstation directory containing network_tf.csv.

🚀 Analysis Workflow

1. Data Processing & Aggregation
The script group-filters unique binding pairs and calculates degree matrices. It formats fields to generate clean, descriptive column headers: Transcription_Factor, Degree, and Hub_Genes_Regulated.

2. Pipeline Execution

Run the full script through your terminal or via RStudio/Rscript:

Rscript tf_degree_ranking.R

📊 Exported Workspace Assets

Upon successful execution, the script generates a series of formatted tables and visualizations in the active root directory:

TF_Ranking_Table.csv - Flat structured matrix	Comprehensive list of all identified TFs sorted by descending degree connectivity.

Top20_TFs.csv	Stratified subset table	Extracted slice featuring the top 20 highest-degree transcription factors.

Top20_TF_Network.csv	Direct Edge List (CSV)	Cleansed sub-network mapping of Name1 and Name2 interactions restricted only to the Top 20 TFs.

HubGene_TF_Summary20.csv	Gene-centric summary table	Matrix detailing the total number of regulatory TFs and collapsed names targeting each separate Hub Gene.

Top20_TF_Barplot.png	High-resolution image (600 DPI)	Horizontal classic bar plot illustrating the top TFs against the count of hub genes they regulate.

📄 License

This analysis framework is open-source and distributed under the MIT License.
