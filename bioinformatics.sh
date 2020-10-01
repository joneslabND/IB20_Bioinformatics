# mcrA total genes file
for file in ref_sequences/mcrAgene*.fasta
do
cat $file >> totalmcrAgene.fasta
done

