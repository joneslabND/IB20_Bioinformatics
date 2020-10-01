#make a directory for  muscle and hmmer files under IB20_Bioinformatics

for sequence in mcrA*
do
cat $sequence >>../muscle_files/ mcrAsequences.txt
done

for sequence in hsp70*
do
cat $sequence >> hsp70sequences.txt
done 

#make a full proteome database
for number in {01..50}; do cat proteome_$number.fasta | sed "s/>/>proteome_$number/g" >> proteomedatabase.fasta; done
