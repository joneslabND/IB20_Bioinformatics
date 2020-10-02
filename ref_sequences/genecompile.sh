# compiles all genes into two files to prep for alignment
# usage: bash genecompile.sh in ref_sequences directory

for file in hsp*.fasta
do
cat $file >> hsp70comp.fasta
done

for file in mcrA*.fasta
do 
cat $file >> mcrAcomp.fasta
done 

