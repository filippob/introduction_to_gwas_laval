###################################################
## here we perform GWAS steps outside of a pipeline
###################################################


-----------------------------
## filtering genotype data ##
-----------------------------

plink --file ~/Share/data/rice --geno 0.05 --mind 0.2 --maf 0.05 --recode --out rice_filtered


--------------------------------------
## imputation of missing genotypes  ##
--------------------------------------

## convert to vcf
plink --file rice_filtered --recode vcf --out rice_filtered


## Beagle
java -Xss5m -Xmx4g -jar ~/Documents/beagle4.1/beagle.27Jan18.7e1.jar gt=rice_filtered.vcf out=rice_imputed
beagle gt=rice_filtered.vcf out=rice_imputed

## convert back to ped/map
plink  --vcf rice_imputed.vcf.gz --recode --out rice_imputed


----------
## GWAS ##
----------

## prepare data for gwas.R
plink --file rice_imputed --recode A --out rice_imputed

## GWAS
Rscript --vanilla ../gwas/gwas.R genotype_file=rice_imputed.raw snp_map=rice_imputed.map phenotype_file=~/Share/data/rice_phenotypes.txt trait=PH trait_label=PH
