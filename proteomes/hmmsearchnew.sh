for file in *.fasta
do
../../../../bin/hmmer/bin/hmmsearch --tblout hmmsearchresults/temp_results ../hsp70hmmbuild $file
../../../../bin/hmmer/bin/hmmsearch --tblout hmmsearchresults/temp_results ../mcrAhmmbuild $file
cat temp_results >> final_results 
done
rm hmmsearchresults/temp_results

