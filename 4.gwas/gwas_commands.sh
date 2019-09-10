

## prepare data for GWAS (Arthur Korte)
plink --file ../imputation/rice_imputed --recode A --out rice_imputed
plink --dog --file ../imputation/dogs_imputed --recode A --out dogs_imputed

## stand-alone script
Rscript --vanilla gwas.R genotype_file=dogs_imputed.raw snp_map=../imputation/dogs_imputed.map phenotype_file=../../data/dogs_phenotypes.txt trait=phenotype trait_label=cleft_lip

## pipeline

