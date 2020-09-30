# This script takes reference sequences for the McrA gene and the HSP70 gene, aligns them,
# builds a hidden markov model (HMM), and searches 50 candidate proteome sequences for these genes using the HMM

# Usage: bash methanogenSearch.sh 

# Make sure you have muscle, hmmsearch, hmmbuild, and the proteome and reference
# sequence folders in your current directory

# Merge reference sequences into a single file
for file in ref_sequences/hsp70gene_*.fasta
do sed '/^>/d' $file > hsp70ref.fasta
done

for file in ref_sequences/mcrAgene_*.fasta
do sed '/^>/d' $file > mcrAref.fasta
done


