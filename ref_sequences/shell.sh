#Usage bash shell.sh

rm mcrAcombo.fasta
rm hsp70combo.fasta
rm hspalignment.fasta
rm mcrAalignment.fasta

for file in mcrAgene_*.fasta
do
cat $file >> mcrAcombo.fasta
done

for file in hsp70gene_*.fasta
do
cat $file >> hsp70combo.fasta
done

./muscle -in hsp70combo.fasta -out hspalignment.fasta

./muscle -in mcrAcombo.fasta -out mcrAalignment.fasta

./hmmbuild hspbuild.fasta hspalignment.fasta

./hmmbuild mcrAbuild.fasta mcrAalignment.fasta
