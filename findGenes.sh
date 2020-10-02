#Usage: bash findGenes.sh reSeqDir proteomeDir outputDir

cat $1/hsp70gene_*.fasta >> $3/hsp_Comp.fasta
cat $1/mcrAgene_*.fasta >> $3/mcrA_Comp.fasta

Bin/muscle -in $3/hsp_Comp.fasta -out $3/hsp_Profile.fasta
Bin/muscle -in $3/mcrA_Comp.fasta -out $3/mcrA_Profile.fasta
	
Bin/hmmbuild $3/hsp_BuildResults.hmm $3/hsp_Profile.fasta
Bin/hmmbuild $3/mcrA_BuildResults.hmm $3/mcrA_Profile.fasta

#Make header for summary results file 
echo file,hsp70geneMatches,mrcAgeneMatches > $3/finalProduct.csv

#Loop to search for proteome
for file in $2/*.fasta
do
	#Create a variable called $name to help name different outputs 
	name=$(echo $file | cut -b 12-22,29-32)
	
	#Search proteome for matching genes 
	Bin/hmmsearch --tblout $3/hspResults_FINAL.search $3/hsp_BuildResults.hmm $file
	Bin/hmmsearch --tblout $3/mcrAResults_FINAL.search $3/mcrA_BuildResults.hmm $file
	
	#Count matches for genes 
	hsp70geneMatches=$(cat $3/hspResults_FINAL.search | grep "WP_" | wc -l)
	mrcAgeneMatches=$(cat $3/mcrAResults_FINAL.search | grep "WP_" | wc -l)

	#Report number of matches 
	echo $name,$hsp70geneMatches,$mrcAgeneMatches >> $3/finalProduct.csv

done


cat $3/finalProduct.csv | sort -t , -n -r -k 3 | head -n 16 | sort -t , -n -r -k 2 >> $3/candidates.csv


