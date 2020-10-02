#This script can be used to align reference proteome files that conatin two specific genes with an 
#entire proteome sequence, build a model for that alignment, and then use that model to search for
#matches. These matches will tell you whether or not the proteomes will carry both of the genes you
#are looking for. 

#usage: bash 

#We created two separate directories to hold the results from using the Bioinformatics tools of 
#muscle and hmmr (build and search). The files contained in those will be used in a for loop that
#will produce a file that will only contain the proteome files that have matches in both genes of 
#interest.
mkdir hsp70outputs
mkdir mcraoutputs

#Within these directories, we ran the muscle tool and hmmr tools to produce all of our outputs that
#we need to go into our for loop as inputs.

#mkdir gene1outputs
#mkdir gene2outputs

#hsp70gene_combined.fasta mcrAgene+combined.fasta

#cd ref_sequences

#mv hsp70gene_combined.fasta ../gene1outputs
#mv mcrAgene+combined.fasta ../gene2outputs

#cd ..

#~/muscle -in gene1outputs/hsp70gene_combined.fasta -out gene1alignment.afa > gene1outputs
#~/muscle -in gene2outputs/mcrAgene+combined.fasta -out gene2alignment.afa > gene2outputs
#~/hmmbuild HMMmodelgene1.afa gene1outputs/gene1alignment.afa
#~/hmmbuild HMMmodelgene2.afa gene2outputs/gene2alignment.afa

mkdir hsp70searches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout hsp70searches/$proteome.hsp70txt gene1outputs/HMMmodelgene1.afa proteomes/$proteome
cd proteomes
done
 
#echo "proteome, number of matches" >>hsp70matches.txt
cd ../hsp70searches
for proteomefile in *fasta.hsp70txt
do
var1=`cat $proteomefile | grep ^WP_ | wc -l`
cd ..
echo "$proteomefile, $var1" >>hsp70matches.txt
cd hsp70searches
done
 
cd ..
mkdir mcrasearches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout mcrasearches/$proteome.mcratxt gene2outputs/HMMmodelgene2.afa proteomes/$proteome
cd proteomes
done
 
#echo proteome, number of matches >mcramatches.txt
cd ../mcrasearches
for proteomefile in *fasta.mcratxt
do
var2=`cat $proteomefile | grep ^WP_ | wc -l`
cd ..
echo "$proteomefile, $var2" >>mcramatches.txt
cd mcrasearches
done
 
cd ..
 
 


cut -d "," -f 2 mcramatches.txt | paste -d, hsp70matches.txt - | sed 's/.fasta.hsp70txt//' > finalmatches.txt  

cat finalmatches.txt | grep -v " 0" | cut -d "," -f 1 | sed 's/.fasta.hsp70txt//' > finalproteomelist.txt

