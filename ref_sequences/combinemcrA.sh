for num in {01..18}
do
cat mcrAgene_$num.fasta | grep -v ">" >> allmcrA.txt
echo "\n" >> allmcrA.txt
done


