#Usage bash shell.sh ref_sequences proteomes

#Remove files from previous trials
rm mcrAcombo.fasta
rm hsp70combo.fasta
rm hspalignment.fasta
rm mcrAalignment.fasta

#Concatenate the mcrAgene sequences into a single file
for file in $1/mcrAgene_*.fasta
do
cat $file >> mcrAcombo.fasta
done

#Concatenate the hsp70 sequences into a single file
for file in $1/hsp70gene_*.fasta
do
cat $file >> hsp70combo.fasta
done

#Align hsp70 using muscle
./muscle -in hsp70combo.fasta -out hspalignment.fasta

#Align mcrA using muscle
./muscle -in mcrAcombo.fasta -out mcrAalignment.fasta

#Build hsp70 profile using hmmbuild
./hmmbuild hspbuild.fasta hspalignment.fasta

#Build mcrA profile using hmmbuild
./hmmbuild mcrAbuild.fasta mcrAalignment.fasta


#Search for mcrA using hmmsearch


#Compile Matching files

#Search for Hsp within matching files

#Return table

#Create .txt file
