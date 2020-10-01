#make a hsp70refs file  and mcrArefs file each containing all the reference sequence for each gene.
cat ref_sequences/hsp70gene_[0-9][0-9].fasta > hsp70refs
cat ref_sequences/mcrAgene_[0-9][0-9].fasta > mcrArefs

#align reference sequence for the two gene from each file containing reference sequences for each gene and make two files named 'hsp70muscleresult' and 'mcrAmuscleresult'
muscle -in hsp70refs -out hsp70muscleresult
muscle -in mcrArefs -out mcrAmuscleresult

#Generate two HMM profiles for hsp70 and mcrA genes separately in two files named 'hsp70hmmbuild' and 'mcrAhmmbuild'
../../../bin/hmmer/bin/hmmbuild hsp70hmmbuild hsp70muscleresult
../../../bin/hmmer/bin/hmmbuild mcrAhmmbuild mcrAmuscleresult

#Search each proteome in the proteomes directory for matches for each gene using the HMM profiles and output a seaparate file with matches for each gene.
cd proteomes
for file in *.fasta
do
../hmmsearch --tblout hsp70_$file ../hsp70hmmbuild $file
../hmmsearch --tblout mcrA_$file ../mcrAhmmbuild $file
done

#Search each result file and print out the proteome name and the matches for hsp70 gene followed by the matches for the mcrA gene.
for file in proteome_{01..50}.fasta
do
match1=$(cat hsp70_$file | grep -v '#' | wc -l)
match2=$(cat mcrA_$file | grep -v '#' | wc -l)
echo "$file,$match1,$match2" | sed 's/.fasta//g'
done

#Removes all the hmmsearchh files created in the proteomes folder so the code won't read those .fasta files when you use the code again.
rm hsp70_proteome_[0-9][0-9].fasta
rm mcrA_proteome_[0-9][0-9].fasta



