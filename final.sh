# this script will align files of interest and will search comparing to the other files; the$
# $1=firstrefgenefile $2=secondrefgenefiles $3=allproteomefastas
# usage bash project.sh hspfiles mcrafiles searchfiles
# on my computer I created a directory called output and the hspfiles/mcrAfiles come from th$
# specific usage for this project:  bash project.sh ./ref_sequences/hsp*.fasta ./ref_sequenc$
# creates directories for results; final table will be in output directory
mkdir output
mkdir ./output/gene1output
mkdir ./output/gene2output
# this will create file with all of the data for each gene and then it'll run the files through muscle and hmmer build
cat $1 > gene1.fasta
~/muscle -in gene1.fasta -out gene1v1.fasta
~/local/bin/hmmbuild gene1v2.fasta gene1v1.fasta
cat $2 > gene2.fasta
~/muscle -in gene2.fasta -out gene2v1.fasta
~/local/bin/hmmbuild gene2v2.fasta gene2v1.fasta

#do not change ./proteomes/*.fasta for $3 because it hasn't been working
# this loop will create the search output for each gene and will assign them to their respective directories
for files in ./proteomes/*.fasta
do
echo $files
name=$(echo $files | cut -d / -f 3 | cut -d . -f 1)
~/local/bin/hmmsearch --tblout ./output/gene1output/${name}_search1output.fasta gene1v2.fast$
~/local/bin/hmmsearch --tblout ./output/gene2output/${name}_search2output.fasta gene2v2.fast$
done

# usage: $4=searchoutputforgene1 $5=searchoutputforgene2
# so in this part we're supposed to create a table that has the proteome, hsp_hits, mcrA_hits
# hits will be calculate by inverse grepping for # and wc the number of lines = number of hi$
# then you will create variables for these (see below) and append to the file finaltable1.csv


cd output
echo "name of proteome,hsp hits,mrcA hits" > finaltable1.csv
cat finaltable1.csv

# make sure you write the mcrA gene as mrcA because I'm lazy :)   
for files in ./gene1output/*.fasta
do
proteome=$(echo $files | cut -d / -f 3 | cut -d _ -f 1,2)
#this will count all hsp hits
hsp_hits=$(cat $files | grep -v "#" | wc -l)
#this will find the corresponding file in the gene2 directory
mrcA_hits=$(cat $(find ./gene2output/${proteome}_search2output.fasta)|  grep -v "#" | wc -l)
# use this for troubleshooting: echo hsp_hits
# use this for troubleshooting: echo mrcA_hits
echo ${proteome},${hsp_hits},${mrcA_hits} >> finaltable1.csv
done

echo "done"
