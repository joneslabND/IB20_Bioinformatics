# Analyzes 50 proteomes for conserved mcrA gene for methoanogenesis and HSP70 gene for pH resistance and puts summary in table in text file

# usage: bash bestmethane.sh <proteome.fasta>

cat ref_sequences/mcrAgene* > allmcrA.fasta
cat ref_sequences/hsp* > allhsp.fasta

# find aligned sequences in hsp and mcrA

~/bin/muscle -in allhsp.fasta -out alignedhsp.fasta

~/bin/muscle -in allmcrA.fasta -out alignedmcrA.fasta

# HMMbuild match conserved sequences

~/bin/hmmer-3.3.1/bin/hmmbuild hspHMM.fasta alignedhsp.fasta

~/bin/hmmer-3.3.1/bin/hmmbuild mcrAHMM.fasta alignedmcrA.fasta

# for loop to search sequence for conserved mcrA and HSP70 genes

mv proteomes/proteome* .

for file in proteome* 
do 
~/bin/hmmer-3.3.1/bin/hmmsearch --tblout tables$file mcrAHMM.fasta $file
~/bin/hmmer-3.3.1/bin/hmmsearch --tblout table$file hspHMM.fasta $file
done

echo "Proteome#, hsp , mcrA" > Hits.txt

for result in tableproteome*
do
	Number=$(echo $result | cut -d . -f 2)
	myvar=$(cat $result | grep -E ^[^"#"]| wc -l)
	echo myvar >> Hits1.txt
	
	
done
  
