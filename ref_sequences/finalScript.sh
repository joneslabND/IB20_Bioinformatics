#combines all hsp70 gene reference files into one fasta file
for num in {01..22}
do
cat hsp70gene_$num.fasta >> allhsp.txt
done

#combines all mcrA gene reference files into one fasta	file
for num in {01..18}
do
cat mcrAgene_$num.fasta >> allmcrA.txt
done

#run muscle to align all hsp70 reference files
../muscle -in allhsp.txt -out alignhsp70.afa

#run muscle to align all mcrA reference files   
../muscle -in allmcrA.txt -out alignmcrA.afa

