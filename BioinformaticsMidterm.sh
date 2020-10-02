#This is the script to run for the Bioinformatics Midterm
#This script searches genomes (proteomes) for genes of interests (hsp70 for pH resistence, and McrA for methanogenisis)
#This script broadly does 3 things: 1) uses muscle to align the hsp genes and the McrA genes 2) uses hmmbuild to ... 3) uses hmmsearch to search the 50 proteomes for matches for the hsp and McrA genes
#Useage: bash BioinformaticsMidterm.sh hsp70gene* mcrA* filetable

cat ref_sequences/$1 > allhsp.fasta
cat ref_sequences/$2 > allmcrA.fasta

#The above 2 lines of code compile all hsp70gene files into one file and all mcrA files into another separate file
#variables are included to make the script more flexible   

./muscle -in allhsp.fasta -out alignedhsp.fasta
./muscle -in allmcrA.fasta -out alignedmcrA.fasta

#The above 2 lines of code use the muscle function to align gene data for future searches

./hmmbuild resultshsp alignedhsp.fasta
./hmmbuild resultsmcrA alignedmcrA.fasta

#The above 2 lines of code are used to build an hmm profile for hsp and mcrA 

cd proteomes
for file in *.fasta
do
	../hmmsearch --tblout ${file}_table1 ../resultshsp $file
	../hmmsearch --tblout ${file}_table2 ../resultsmcrA $file
done

#The above for loop executes a hmmsearch and outputs the results to a table. The end result of this code creates 100 tables - 2 for each unique protemone (one for hsp70gene and one for mrcA)

echo proteome name, #hsp70, #mcrA > finaltable

#This creates a table file with the appropriate headers. The following code will build the table line by line

for $file in *.fasta
do hsp=$(cat ${file}_table1 | grep -v "#" | wc-l) mcrA=$(cat ${file}_table2 | grep -v "#") 
   echo "$name,$hsp,$mcrA" >> finaltable
done

#The above for loop will loop 50 proteome files, storing the "hits" for mcrA and hsp based off of the respective tables, then the name of the proteome along with the # of hits will be printed and redirect to the finaltable file
 
