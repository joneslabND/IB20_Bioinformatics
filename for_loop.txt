echo Proteome Name HSP 70 McrA >> summary_table.txt

cd proteomes

for file in *.fasta

do

HSP=$(grep "WP" ../hmmr_search_results_hsp/hsp_search_$file | wc -l)
MCR=$(grep "WP" ../hmmr_search_results_mcr/mcr_search_$file | wc -l)

echo $file $HSP $MCR >> ../summary_table.txt
 
done

cd ..

