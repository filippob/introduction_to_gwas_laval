## prepare the env

cp -r ../software .
cp ../gwas.R software/
cp -r ../../data .
mkdir steps


## dry run
snakemake -n -s Snakefile_GWAS_continuous
