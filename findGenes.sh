#Usage: bash findGenes.sh reSeqDir proteomeDir outputDir

cat $1/hsp70gene_*.fasta >> $3/hsp_Comp.fasta
cat $1/mcrAgene_*.fasta >> $3/mcrA_Comp.fasta

~/Bin/muscle -in $3/hsp_Comp -out hsp_Profile.fasta
~/Bin/muscle -in $3/mcrA_Comp -out mcrA_Profile.fasta
	
~/Bin/hmmbuild $3/hsp_BuildResults.hmm $3/hsp_Profile.fasta
~/Bin/hmmbuild $3/mcrA_BuildResults.hmm $3/mcrA_Profile.fasata

#Make header for summary results file 
echo “file,hsp70geneMatches,mrcAgeneMatches” > $3/finalProduct.csv

#Loop to search for proteome
for file in $2/*.fasta
do
	#Search proteome for matching genes 
	~/Bin/hmmsearch $3/hspResults_FINAL.search $3/hsp_BuildResults.hmm $file
	~/Bin/hmmsearch $3/mcrAResults_FINAL.search $3/mcrA_BuildResults.hmm $file
	
	#Count matches for genes 
	hsp70geneMatches=$(cat $3/hspResults_FINAL.search | grep | wc)
	mrcAgeneMatches=$(cat $3/mcrAResults_FINAL.search | grep | wc)

	#Report number of matches 
	echo “$file,$hsp70geneMatches,$mrcAgeneMatches >> $3/finalProduct.csv

done

