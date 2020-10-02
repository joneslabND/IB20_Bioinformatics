# This script takes reference sequences for the McrA gene and the HSP70 gene, aligns them,
# builds a hidden markov model (HMM), and searches 50 candidate proteome sequences for these genes using the HMM

# Usage: bash methanogenSearch.sh 

# Make sure you have muscle, hmmsearch, hmmbuild, and the proteome and reference
# sequence folders in your current directory
rm hsp70ref.fasta
rm mcrAref.fasta

# Merge reference sequences into a single file
for file in ref_sequences/hsp70gene_*.fasta
do cat $file >> hsp70ref.fasta
#do sed '/^>/d' $file >> hsp70ref.fasta
done

for file in ref_sequences/mcrAgene_*.fasta
do cat $file >> mcrAref.fasta
#do sed '/^>/d' $file >> mcrAref.fasta
done


./muscle -in mcrAref.fasta -out mcrA.aligned  #for McrA first on mcrAref.fasta, to align the sequences

./hmmbuild mcrA.hmm mcrA.aligned  #to build a HMM based on the output of muscle, above

./muscle -in hsp70ref.fasta -out hsp70.aligned #for Hsp70 gene, to align these sequences

./hmmbuild hsp70.hmm hsp70.aligned  #to build a HMM based on the output of muscle, above

# ./hmmsearch, for 50 times per for the methanogen gene, then output 

# ./take only the proteomes that are identified as methanogens and then do ./hmmsearch again to find ph resistant sequences only in these proteomes
