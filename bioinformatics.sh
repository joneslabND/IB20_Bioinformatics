#This script can be used to align reference proteome files that conatin two specific genes with an 
#entire proteome sequence, build a model for that alignment, and then use that model to search for
#matches. These matches will tell you whether or not the proteomes will carry both of the genes you
#are looking for. 

#usage: bash bioinformatics.sh  directory1 directory2

#We created two separate directories to hold the results from using the Bioinformatics tools of 
#muscle and hmmr (build and search). The files contained in those will be used in a for loop that
#will produce a file that will only contain the proteome files that have matches in both genes of 
#interest.

#directory 1 is the directory in which the muscle alignment and hidden markov model for the hsp70 gene will be placed, as well as the combined reference code for the hsp70 genes
#directory 2 is the directory in which the muscle alignment and the hidden markov model for the mcra gene will be placed, as well as the combined reference code for the mcra gene


#ensure	reference sequences are	in the ref_sequences directory,	and make sure that proteome sequences are in the proteome directory

#Within these directories, we ran the muscle tool and hmmr tools to produce all of our outputs that
#we need to go into our for loop as inputs.

mkdir $1
mkdir $2

cd ref_sequences

cat hsp70gene* > hsp70gene_combined.fasta
cat mcrAgene* > mcrAgene+combined.fasta

mv hsp70gene_combined.fasta ../$1
mv mcrAgene+combined.fasta ../$2

cd ..

~/muscle -in ./$1/hsp70gene_combined.fasta -out gene1alignment.afa 
~/muscle -in ./$2/mcrAgene+combined.fasta -out gene2alignment.afa
~/hmmbuild HMMmodelgene1.afa gene1alignment.afa
~/hmmbuild HMMmodelgene2.afa gene2alignment.afa

mv gene1alignment.afa HMMmodelgene1.afa $1
mv gene2alignment.afa HMMmodelgene2.afa $2

#The hsp70searches directory is made to include the outputs of hmmsearch with the proteome
#file and HMMmodelgene1.afa which is the model hidden markov model built for hsp70.
 
mkdir hsp70searches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout hsp70searches/$proteome.hsp70txt $1/HMMmodelgene1.afa proteomes/$proteome
cd proteomes
done
 
#This for loop takes the outputs in hsp70 earches and counts the number of lines that start
#with “WP_” indicating the presence of a match in the code. A new file is made called
#hsp70matches.txt in the main folder where the bash script is run. This file includes the list
#of all of the proteomes and the number of hsp70 gene matches each proteome has. 
 
 
cd ../hsp70searches
for proteomefile in *fasta.hsp70txt
do
var1=`cat $proteomefile | grep ^WP_ | wc -l`
cd ..
echo "$proteomefile, $var1" >>hsp70matches.txt
cd hsp70searches
done

#The mcrasearches directory is made to include the outputs of hmmsearch with the proteome
#file and HMMmodelgene2.afa which is the model hidden markov model built for the gene mcra.
 
cd ..
mkdir mcrasearches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout mcrasearches/$proteome.mcratxt $2/HMMmodelgene2.afa proteomes/$proteome
cd proteomes
done
 
#This for loop takes the outputs in mcrasearches and counts the number of lines that start with 
#“WP_” indicating the presence of a match in the code. A new file is made called mcramatches.txt in
#the main folder where the bash script is run. This file includes the list of all of
#the proteomes and the number of mcra gene matches each proteome has. 
 
 
cd ../mcrasearches
for proteomefile in *fasta.mcratxt
do
var2=`cat $proteomefile | grep ^WP_ | wc -l`
cd ..
echo "$proteomefile, $var2" >>mcramatches.txt
cd mcrasearches
done
 
cd ..
 
#this line of code takes the second column from mcramatches.txt, the number of mcramatches for 
#each proteome, and adds it to the existing hsp70matches.txt file, in the process creating a new 
#file called finalmatches.txt

cut -d "," -f 2 mcramatches.txt | paste -d, hsp70matches.txt - | sed 's/.fasta.hsp70txt//' > finalmatches.txt  

#this searches for all of the proteomes that have 0 matches with either the mcra or hsp70 gene,
#in which case, they are not returned. Thus a final list of recommended proteomes that has 
#matches with both mcra and hps70 is put into finalproteomelist.txt

cat finalmatches.txt | grep -v " 0" | cut -d "," -f 1 | sed 's/.fasta.hsp70txt//' > finalproteomelist.txt


#output: final matches.txt contains the list of proteomes with the number of hsp70 matches in the
#first column and the number of mcra matches in the second column for each proteome

#output: finalproteomelist.txt contains the list of proteomes that has matches with both genes 
#and is therefore recommended for this project

