# mcrA total genes file
for file in ref_sequences/mcrAgene*.fasta
do
cat $file >> totalmcrAgene.fasta
done

# hsp70 total genes file
for file in ref_sequences/hsp70gene*.fasta
do
cat $file >> totalhsp70gene.fasta
done

