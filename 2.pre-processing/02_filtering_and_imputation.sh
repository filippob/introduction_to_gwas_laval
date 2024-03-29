#!/bin/bash
#########################
## DATA FILTERING
#########################

## command lines (and instruction) for data filtering, imputation and preparation (for GWAS)

## filtering genotype data
plink --file ../data/rice --geno 0.05 --mind 0.2 --maf 0.05 --recode --out rice_filtered
plink --dog --file ../data/dogs --geno 0.05 --mind 0.2 --maf 0.05 --recode --out dogs_filtered

#########################
## IMPUTATION
#########################

## imputation of missing genotypes

cd ../3.imputation

## prepare rice data
plink --file ../2.pre-processing/rice_filtered --recode vcf --out rice_filtered

## prepare dogs data
## option 1)

sed -i 's/\_//g' ../2.pre-processing/dogs_filtered.ped ## this is to solve the issue with multiple underscores (Plink doesn't handle it well)
plink --dog --file ../2.pre-processing/dogs_filtered --recode vcf --out dogs_filtered

## option 2) directly handle sample labels with Plink
plink --dog --file ../2.pre-processing/dogs_filtered --recode vcf-iid --out dogs_filtered

#java -Xss5m -Xmx4g -jar ~/Documents/beagle4.1/beagle.27Jan18.7e1.jar gt=rice_filtered.vcf out=rice_imputed
#java -Xss5m -Xmx4g -jar ~/Documents/beagle4.1/beagle.27Jan18.7e1.jar gt=dogs_filtered.vcf out=dogs_imputed

beagle gt=rice_filtered.vcf out=rice_imputed
beagle gt=dogs_filtered.vcf out=dogs_imputed

plink  --vcf rice_imputed.vcf.gz --recode --out rice_imputed
plink --dog --vcf dogs_imputed.vcf.gz --recode --out dogs_imputed

## prepare data for GWAS (basic model and PC's)
plink --file rice_imputed --make-bed --out rice_imputed
plink --dog --file dogs_imputed --make-bed --out dogs_imputed


## prepare data for GWAS (Arthur Korte)
plink --file rice_imputed --recode A --out rice_imputed
plink --dog --file dogs_imputed --recode A --out dogs_imputed
