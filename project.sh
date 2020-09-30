# this script will align files of interest and will search comparing to the other files; then, it'll create a file for each
# $1=firstrefgenefile $2=secondrefgenefiles $3=allproteomefastas
# usage bash project.sh hspfiles mcrafiles searchfiles
# on my computer I created a directory called output and the hspfiles/mcrAfiles come from the ref_sequences directory
# specific usage for this project:  bash project.sh ./ref_sequences/hsp*.fasta ./ref_sequences/mcr*.fasta ./proteomes/*.fasta ./output/*_search1output.fasta ./output/*_search2output.fasta

cat $1 > gene1.fasta
~/muscle -in gene1.fasta -out gene1v1.fasta
~/local/bin/hmmbuild gene1v2.fasta gene1v1.fasta
cat $2 > gene2.fasta
~/muscle -in gene2.fasta -out gene2v1.fasta
~/local/bin/hmmbuild gene2v2.fasta gene2v1.fasta

#do not change ./proteomes/*.fasta for $3 because it hasn't been working

for files in ./proteomes/*.fasta
do
echo $files
name=$(echo $files | cut -d / -f 3 | cut -d . -f 1)
~/local/bin/hmmsearch --tblout ./output/${name}_search1output.fasta gene1v2.fasta ${files}
~/local/bin/hmmsearch --tblout ./output/${name}_search2output.fasta gene2v2.fasta ${files}
done

# usage: $4=searchoutputforgene1 $5=searchoutputforgene2
# so in this part we're supposed to create a table that has the proteome, hsp_hits, mcrA_hits
# hits will be calculate by inverse grepping for # and wc the number of lines = number of hits
# then you will create variables for these (see below) and append to the file finaltable1.csv


cd output
echo "name of proteome,hsp hits,mcrA hits" > finaltable1.csv
cat finaltable1.csv

for files in $4 $5
do
proteome=$(echo *_search1output.fasta | cut -d _ -f 1,2)
hsp_hits=$(cat *_search1output.fasta | grep -v "#" | wc -l)
mrcA_hits=$(cat *_search2output.fasta | grep -v "#" | wc -l)
echo $proteome
echo $mcrA_hits
echo ${proteome},${hsp_hits},${mcrA_hits} >> finaltable1.csv
echo "last step"
done

echo "done"
