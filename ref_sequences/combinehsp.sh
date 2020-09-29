for num in {01..22}
do
cat hsp70gene_$num.fasta | grep -v ">" >> allhsp70.txt
echo "\n" >> allhsp70.txt
done

