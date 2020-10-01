# start in IB20_Bioinformatics directory
# usage: 
# output:
mkdir working_files

cd ref_sequences

for sequence in mcrA*
do
cat $sequence >> ../working_files/mcrAsequences.txt
done

for sequence in hsp70*
do
cat $sequence >> ../working_files/hsp70sequences.txt
done 
