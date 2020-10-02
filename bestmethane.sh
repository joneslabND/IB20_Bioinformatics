# Analyzes 50 proteomes for conserved mcrA gene for methoanogenesis and HSP70 gene for pH resistance and puts summary in table in text file

# usage: bash bestmethane.sh <proteome.fasta>

cat ref_sequences/mcrAgene* > allmcrA.fasta
cat ref_sequences/hsp* > allhsp.fasta

# find aligned sequences in hsp and mcrA

~/bin/muscle -in allhsp.fasta -out alignedhsp.fasta

~/bin/muscle -in allmcrA.fasta -out alignedmcrA.fasta

# HMMbuild match conserved sequences

~/bin/hmmer-3.3.1/src/hmmbuild hspHMM.fasta alignedhsp.fasta

~/bin/hmmer-3.3.1/src/hmmbuild mcrAHMM.fasta alignedmcrA.fasta

# for loop to search sequence for conserved mcrA and HSP70 genes

for file in proteomes/proteome* 
do 
~/bin/hmmer-3.3.1/src/hmmsearch -o tables$file $file allmcrA.fasta >> $file
~/bin/hmmer-3.3.1/src/hmmsearch -o table$file $file allhsp.fasta >> $file
done

