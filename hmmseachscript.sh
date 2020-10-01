for file in proteomes/*.fasta
do
./hmmsearch --tblout ./hsp70_$file hsp70hmmbuild $file
./hmmsearch --tblout ./mcrA_$file mcrAhmmbuild $file
done
