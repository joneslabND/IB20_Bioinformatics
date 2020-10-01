#Combine all hsp 70  sequences together on one file
for gene in hsp70*.fasta
do 
cat $gene >> hsp70.fa
done

#Combine all mcr sequences together on one file
for gene in mcr*.fasta
do
cat $gene >> mcr.fa
done
 
#aligning the hsp70 sequences
for hsp70.fa
do
./muscle -in hsp70.fa -out hsp70.afa
done

#aligning the mcr sequences
for mcr.fa
do
./muscle -in mcr.fa -out mcr.afa
done

#hmm build a similarities thingy
for mcr.afa
do 
hmmbuild mcr.hmm mcr.afa
done

#hmm build
for hsp70.afa
do
hmmbuild hsp70.hmm hsp70.afa
done

#hmm search
for *.fa
do
hmmsearch -tblout hsp70.hmm 
done

#hmm search
for *.fa
do
hmmsearch -tblout mcr.hmm
done
