# Hope Baldwin and Morgan Hiller
# usage: bash projectScript.sh

# combine all hsp sequences to one file
for file in ref_sequences/hsp*
do
	cat $file >> combinedHSP.fasta
done

# use muscle to align sequences
./muscle -in combinedHSP.fasta -out alignedHSP

# build from the alignment file 
./hmmbuild buildHSP alignedHSP

# combine all mcr sequences to one file
for file in ref_sequences/mcr*
do
  	cat $file >> combinedMCR.fasta
done

# use muscle to align sequences
./muscle -in combinedMCR.fasta -out alignedMCR

# build from the alignment file
./hmmbuild buildMCR alignedMCR 

# create variable to count the proteomes
var=1

# loop through each proteome and run a hsp and mcr search on each one
for file in proteomes/*.fasta
do
	./hmmsearch --tblout tableHSP${var} buildHSP $file
	./hmmsearch --tblout tableMCR${var} buildMCR $file
	var=$((var+1))
done

var=$((var-1))

# Create final ouput table
echo "Proteome #, HSP, MCR" > resultsTable.txt
for num in $(seq 1 $var)
do
	# use grep to count the number of matches
	hspCount=$(cat tableHSP$num | grep -v -c "#")  
	mcrCount=$(cat tableMCR$num | grep -v -c "#")
	
	# store in final table
	echo "$num, $hspCount, $mcrCount" >> resultsTable.txt
	
done 

# Put the proteomes that have at least 1 mcr and at least 2 hsp into a text file
echo "Proteome numbers of the candidate pH-resistant methanogens" > resultProteomes.txt
cat resultsTable.txt | grep -E "[0-9]+, [2-N], [1-N]" | cut -d , -f 1 >> resultProteomes.txt


# delete combined files so when we run the code again it will not append on to the old ones
rm combinedHSP.fasta
rm combinedMCR.fasta



