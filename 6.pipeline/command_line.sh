#!/bin/bash
## prepare the env

mkdir data 2>/dev/null
mkdir steps 2>/dev/null
cp -r ../software .
cp ../4.gwas/gwas.R software
cp -r ../data/{dogs,rice,parus}.{ped,map} data
cp -r ../data/{dogs,rice,parus}_phenotypes.txt data

## dry run
snakemake --dag -s Snakefile_GWAS_parus | dot -Tsvg > graph.svg
snakemake -s Snakefile_GWAS_parus
