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

#build hidden markov model for hsp70 references
hmmbuild hsp.HMM alignhsp70.afa

#build hidden markov model for mcrA references
hmmbuild mcrA.HMM alignmcrA.afa

#search	all 50 proteomes using hsp.HMM as search criteria
for num in {01..50}
do
hmmsearch hsp.HMM proteome_$num.fasta >> hsp_proteomes.txt
done

#search all 50 proteomes using mcrA.HMM as search criteria
for num in {01..50}
do
hmmsearch mcrA.HMM proteome_$num.fasta >> mcrA_proteomes.txt
done
