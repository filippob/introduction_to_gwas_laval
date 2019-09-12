--------------------------------------
## imputation of missing genotypes  ##
--------------------------------------

## convert to vcf
plink --file rice_filtered --recode vcf --out rice_filtered

plink --dog --file dogs_filtered --recode vcf --out dogs_filtered	## check the warning on underscores !!
plink --dog --file dogs_filtered --recode vcf-iid --out dogs_filtered

## Beagle
beagle gt=rice_filtered.vcf out=rice_imputed
beagle gt=dogs_filtered.vcf out=dogs_imputed

## convert back to ped/map
plink --vcf rice_imputed.vcf.gz --recode --out rice_imputed
plink --dog --vcf dogs_imputed.vcf.gz --recode --out dogs_imputed

