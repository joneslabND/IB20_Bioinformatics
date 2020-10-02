for file in *.fasta
do
../../../../bin/hmmer/bin/hmmsearch --tblout hmmsearchresults/hsp70_$file ../hsp70hmmbuild $file
../../../../bin/hmmer/bin/hmmsearch --tblout hmmsearchresults/mcrA_$file ../mcrAhmmbuild $file
done
