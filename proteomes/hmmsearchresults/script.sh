for file in *.fasta
do
file1=$(grep -E 'hsp70_proteome[0-9][0-9]')
echo $file,$file1
done
