# This script takes reference sequences for the McrA gene and the HSP70 gene, aligns them,
# builds a hidden markov model (HMM), and searches 50 candidate proteome sequences for these genes using the HMM

# Usage: bash methanogenSearch.sh 

# Make sure you have muscle, hmmsearch, hmmbuild, and the proteome and reference
# sequence folders in your current directory

# For debugging -- remove files that are generated within the script, to avoid soft errors when re-running the script
# rm hsp70ref.fasta
# rm mcrAref.fasta
#rm mcrA.aligned
#rm hsp70.aligned
#rm mcrA.hmm
#rm hsp70.hmm
#rm hsp70results
#rm ./proteomes/mcrAsearch*.fasta
#rm ./proteomes/hsp70search*.fasta


# Merge reference sequences into a single file
for file in ref_sequences/hsp70gene_*.fasta
do cat $file >> hsp70ref.fasta
done

for file in ref_sequences/mcrAgene_*.fasta
do cat $file >> mcrAref.fasta
done


./muscle -in mcrAref.fasta -out mcrA.aligned  #for McrA first on mcrAref.fasta, to align the sequences

./hmmbuild mcrA.hmm mcrA.aligned  #to build a HMM based on the output of muscle, in line above

./muscle -in hsp70ref.fasta -out hsp70.aligned #for Hsp70 gene, to align these sequences

./hmmbuild hsp70.hmm hsp70.aligned  #to build a HMM based on the output of muscle, in line above
 
# Perform hmmsearch for all 50 proteomes of interest based on the hsp70 and mcrA HMMs
for file in ./proteomes/*.fasta
do
./hmmsearch --tblout $file.mcrAresult mcrA.hmm $file
./hmmsearch --tblout $file.hsp70result hsp70.hmm $file
done

# search the text files generated from hmmsearch for the number of matches, and output this to a separate text file, "proteomeMatches.txt"

echo "ProteomeNumber, mcrA matches, hsp70 matches:" >> proteomeMatches.txt

cd ./proteomes

# For loop which looks at all of the output files from the hmmsearch step, assigns the number of matches for mcrA and hsp70 to i and j respectively, and outputs this to a text file

for number in {01..50}
do
i=$(cat proteome_$number.fasta.mcrAresult | grep -v "^#" | grep -v "protein" | wc -l)
j=$(cat proteome_$number.fasta.hsp70result | grep -v "^#" | grep -v "protein" | wc -l)
echo "Proteome $number, $i, $j" >> proteomeMatches.txt
done

mv proteomeMatches.txt ..
