###################################################
## here we perform GWAS steps outside of a pipeline
###################################################


-----------------------------
## filtering genotype data ##
-----------------------------

plink --file ~/Share/data/rice --geno 0.05 --mind 0.2 --maf 0.05 --recode --out rice_filtered
~/Downloads/plink --file ~/Share/data/rice --geno 0.05 --mind 0.2 --maf 0.05 --recode --out rice_filtered

plink --file ~/Share/data/dogs --dog --geno 0.05 --mind 0.2 --maf 0.05 --recode --out dogs_filtered

--------------------------------------
## imputation of missing genotypes  ##
--------------------------------------

## convert to vcf
plink --file rice_filtered --recode vcf --out rice_filtered
~/Downloads/plink --file rice_filtered --recode vcf --out rice_filtered

plink --dog --file dogs_filtered --recode vcf --out dogs_filtered	## check the warning on underscores !!
plink --dog --file dogs_filtered --recode vcf-iid --out dogs_filtered

## Beagle
java -Xss5m -Xmx4g -jar ~/Documents/beagle4.1/beagle.27Jan18.7e1.jar gt=rice_filtered.vcf out=rice_imputed
beagle gt=rice_filtered.vcf out=rice_imputed

beagle gt=dogs_filtered.vcf out=dogs_imputed

## convert back to ped/map
plink --vcf rice_imputed.vcf.gz --recode --out rice_imputed
~/Downloads/plink  --vcf rice_imputed.vcf.gz --recode --out rice_imputed

plink --dog --vcf dogs_imputed.vcf.gz --recode --out dogs_imputed

----------
## GWAS ##
----------

## prepare data for gwas.R
plink --file rice_imputed --recode A --out rice_imputed
~/Downloads/plink --file rice_imputed --recode A --out rice_imputed

plink --dog --file dogs_imputed --recode A --out dog_imputed


## GWAS
Rscript --vanilla ../gwas/gwas.R genotype_file=rice_imputed.raw snp_map=rice_imputed.map phenotype_file=~/Share/data/rice_phenotypes.txt trait=PH trait_label=PH
Rscript --vanilla ../gwas/gwas.R genotype_file=dogs_imputed.raw snp_map=dogs_imputed.map phenotype_file=~/Share/data/dogs_phenotypes.txt trait=phenotype trait_label=cleft_lip

