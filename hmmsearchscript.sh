for file in proteomes/*.fasta
do
./hmmer/bin/hmmsearch --tblout hsp70_$file hsp70hmmbuild $file
./hmmer/bin/hmmsearch --tblout mcrA_$file mcrAhmmbuild $file
done

 
