for sequence in mcrA*
do
cat $sequence >> mcrAsequences.txt
done

for sequence in hsp70*
do
cat $sequence >> hsp70sequences.txt
done 
