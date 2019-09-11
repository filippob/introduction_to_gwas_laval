#!/bin/bash
## prepare the env

mkdir data 2>/dev/null
mkdir steps 2>/dev/null
cp -r ../software .
cp ../4.gwas/gwas.R software
cp -r ../data/{dogs,rice}.{ped,map} data
cp -r ../data/{dogs,rice}_phenotypes.txt data

## dry run
snakemake -n -s Snakefile_GWAS_continuous
