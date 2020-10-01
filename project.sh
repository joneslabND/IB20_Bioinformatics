#make a directory for  muscle and hmmer files under IB20_Bioinformatics

for sequence in mcrA*
do
cat $sequence >> ../muscle_files/mcrAsequences.txt
done

for sequence in hsp70*
do
cat $sequence >> ../muscle_files/hsp70sequences.txt
done 
