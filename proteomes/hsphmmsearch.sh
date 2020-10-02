for num in {01..50}
do
hmmsearch hsp.HMM proteome_$num.fasta >> hsp_proteomes.txt
done
