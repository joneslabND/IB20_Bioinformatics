# This script...
# Usage:
# Merge reference sequences into a single file
for file in ref_sequences/hsp70gene_*.fasta
do sed '/^>/d' $file >> hsp70ref.fasta
done

for file in ref_sequences/mcrAgene_*.fasta
do sed '/^>/d' $file >> mcrAref.fasta
done
