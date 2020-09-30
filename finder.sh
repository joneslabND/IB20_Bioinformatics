#make a hsp70refs file  and mcrArefs file each containing all the reference sequence for each gene.
cat ref_sequences/hsp70gene_[0-9][0-9].fasta > hsp70refs
cat ref_sequences/mcrAgene_[0-9][0-9].fasta > mcrArefs

#align reference sequence for the two gene from each file containing reference sequencea for each gene and make two files named 'hsp70muscleresult' and 'mcrAmuscleresult'
muscle -in hsp70refs -out hsp70muscleresult
muscle -in mcrArefs -out mcrAmuscleresult

#Generate two HMM profiles for hsp70 and mcrA genes separately in two files named 'hsp70hmmbuild' and 'mcrAhmmbuild'
../../../bin/hmmer/bin/hmmbuild hsp70hmmbuild hsp70muscleresult
../../../bin/hmmer/bin/hmmbuild mcrAhmmbuild mcrAmuscleresult

