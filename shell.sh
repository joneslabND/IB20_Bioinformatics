#Usage bash shell.sh ./ref_sequences ./proteomes when ran from IB20_Bioinformatics
#Must change path to mucsle, hmmbild, hmmsearch for your machine
#Creates summary.csv and candidates.txt files

#Concatenate the mcrAgene sequences into a single file
cat $1/mcrAgene_*.fasta > mcrAcombo.fasta


#Concatenate the hsp70 sequences into a single file
cat $1/hsp70gene_*.fasta > hsp70combo.fasta


#Align hsp70 using muscle
$1muscle -in hsp70combo.fasta -out hspalignment.fasta


#Align mcrA using muscle
$1muscle -in mcrAcombo.fasta -out mcrAalignment.fasta


#Build hsp70 profile using hmmbuild
$1hmmbuild hspbuild.fasta hspalignment.fasta


#Build mcrA profile using hmmbuild
$1hmmbuild mcrAbuild.fasta mcrAalignment.fasta


#Initialize Summary Table
echo "Proteome, McrA, HSP" > summary.csv


#Search for mcrA and hsp using hmmsearch

for file in $2proteome_*.fasta

do

name=$(echo $file | cut -d "." -f 2 | cut -d "/" -f 3)

$2hmmsearch --tblout mcrAsearch."$name".txt mcrAbuild.fasta $file
$2hmmsearch --tblout hspsearch."$name".txt hspbuild.fasta $file

hsphits=$(cat hspsearch."$name".txt | grep -v "#"| wc -l)

mcrAhits=$(cat mcrAsearch."$name".txt | grep -v "#" | wc -l)

echo "$name,$mcrAhits,$hsphits" >> summary.csv

done

#Sort table by number of mcrA matches
cat summary.csv | sort --field-separator=',' -k 2

#Create text file with possible candidates
cat summary.csv |sort -r --field-separator=',' -k 3 | sed -E 's/,/ /g' | grep -v -w "0" | cut -d " " -f 1 > candidates.txt

cat candidates.txt
