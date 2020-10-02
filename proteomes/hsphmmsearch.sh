mkdir hspresults
for num in {01..50}
do
hmmsearch --tblout hspresults/hspsearchoutput_proteome$num.HMM hsp.HMM proteome_$num.fasta
done
