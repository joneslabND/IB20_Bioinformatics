mkdir mcraresults
for num in {01..50}
do
hmmsearch --tblout mcraresults/mcrasearchoutput_proteome$num.HMM mcrA.HMM proteome_$num.fasta
done
