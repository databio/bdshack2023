# 2023 SBDS Hackathon
## Data overview:
The dataset for this competition comprises single-cell multiomics data collected from mobilized peripheral CD34+ hematopoietic stem and progenitor cells (HSPCs) isolated from four healthy human donors. All measurements were taken at five time points over a ten-day period.

From each culture plate at each sampling time point, cells were collected for measurement with two single-cell assays. The first is the 10x Chromium Single Cell Multiome ATAC + Gene Expression technology (Multiome) and the second is the 10x Genomics Single Cell Gene Expression with Feature Barcoding technology using the TotalSeq-B Human Universal Cocktail, V1.0(CITEseq).

Each assay technology measures two modalities. The Multiome kit measures chromatin accessibility (DNA) and gene expression (RNA), while the CITEseq kit measures gene expression (RNA) and surface protein levels.

Following the central dogma of molecular biology: DNA --> RNA-->Protein, your task is as follows:
	1. For the Multiome samples: given chromatin accessibility, predict gene expression.
	2. For the CITEseq samples: given gene expression, predict protein levels.

File and Field Descriptions
--> metadata.csv
	cell_id - A unique identifier for each observed cell.
	donor - An identifier for the four cell donors.
	day - The day of the experiment the observation was made.
	technology - Either citeseq or multiome.
	cell_type - One of the above cell types or else hidden.

The experimental observations are contained in several large arrays. We provide these arrays in HDF5 format.

1. Multiome:
--> train/test_multi_inputs.h5 - ATAC-seq peak counts transformed with TF-IDF using the default log(TF) * log(IDF) output (chromatin accessibility), with rows corresponding to cells and columns corresponding to the location of the genome whose level of accessibility is measured, here identified by the genomic coordinates on reference genome GRCh38 provided in the 10x References - 2020-A (July 7, 2020).

--> train_multi_targets.h5 - RNA gene expression levels as library-size normalized and log1p transformed counts for the same cells.

2. CITEseq:
--> train/test_cite_inputs.h5 - RNA library-size normalized and log1p transformed counts (gene expression levels), with rows corresponding to cells and columns corresponding to genes given by {gene_name}_{gene_ensemble-ids}.

--> train_cite_targets.h5 - Surface protein levels for the same cells that have been dsb normalized.

3. Splits:
The data splits are arranged as follows:
> The training set comprises samples only from donors 13176,31800, and 32606. The public test set comprises samples only from donor 27678. The private test set comprises samples from all four donors.
> For the Multiome samples, the training set comprises samples only from days 2,3,4, and 7. The public test set comprises samples only from days 2,3, and 7. The private test set comprises data only from day 10.
> For the CITEseq samples, the training set comprises samples only from days 2,3, and 4. The public test set also comprises samples only from days 2,3, and 4. The private test set comprises samples only from day 7. There are no day 10 CITEseq samples in any split.

Your task is to predict the labels corresponding to the inputs in the test set. To facilitate submission scoring, we only require predictions on a subset of the Multiome data. This subset was created by sampling 30% of the Multiome rows, and for each row, 15% of the columns. The sample of columns varies from row-to-row. All of the CITEseq labels are scored.

--> evaluation_ids.csv - Identifies the labels from the test set to be evaluated. It provides a join key from the cell_id/gene_id identifiers of the label matrix to the row_id needed for the submission file.

--> sample_submission.csv - A sample submission file in the correct format. See the Evaluation page for more information.


