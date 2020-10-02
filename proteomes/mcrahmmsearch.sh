for num in {01..50}
do
hmmsearch mcrA.HMM proteome_$num.fasta >> mcrA_proteomes.txt
done
