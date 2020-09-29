# search for genes within each proteome
# make sure path to hmmbuild results is correct
# bash search.sh in proteome directory

for file in proteome*.fasta
do
~/Bin/hmmer/hmmsearch --tblout ./searchresults/"$file".hsp70 ~/Private/bioproject/ref_sequences/hsp70.built "$file"
done

for file in proteome*.fasta
do
~/Bin/hmmer/hmmsearch --tblout ./searchresults/"$file".mcrA ~/Private/bioproject/ref_sequences/mcrA.built "$file"
done
