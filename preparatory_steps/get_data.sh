###################################
## RICE DATA (continuous)
###################################

## Download data (rice, continuous)
wget https://zenodo.org/record/50803/files/GBSgenotypes.tar.gz
wget https://zenodo.org/record/50803/files/plantgrainPhenotypes.txt

tar -xvzf GBSgenotypes.tar.gz

wc -l GBSnew.ped
wc -l GBSnew.map

wc -l plantgrainPhenotypes.txt
less -S plantgrainPhenotypes.txt

## retrieve group information
## create new phenotypes file and ids file for Plink subsetting
Rscript prep_rice_data.R plantgrainPhenotypes.txt rice_group.reference PH


## use Plink to subset data
~/Downloads/plink --file GBSnew --keep ids --chr 1,2,6,7 --recode --out rice


###################################
## DOG DATA (binary)
###################################

## Download data
wget https://datadryad.org/bitstream/handle/10255/dryad.77584/UCD_2014.tfam
wget https://datadryad.org/bitstream/handle/10255/dryad.77585/UCD_2014.tped

## prep phenotypes
Rscript --vanilla prep_dogpheno.R UCD_2014.tfam

## subset genotypes
~/Downloads/plink --dog --tfile UCD_2014 --chr 25,26,27,28,29 --recode --out dogs
