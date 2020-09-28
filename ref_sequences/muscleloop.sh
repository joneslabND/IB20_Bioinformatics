# runs muscle on all refseq fasta files and ouputs the alignment
# usage: bash muscleloop.sh in ref_sequences

for file in ref_sequences
do
./muscle -in $file -out $filealigned.fasta
done

