# Analyzes 50 proteomes for conserved mcrA gene for methoanogenesis and HSP70 gene for pH resistance and puts summary in table in text file

# usage: bash bestmethane.sh <proteome.fasta>

# for loop to find aligned sequences in proteomes

for file in proteomes/proteome_*
do
~/bin/muscle -in $file -out aligned$file -maxiters 1 -diags1 -sv
done

# for loop to match conserved sequences

for file in aligned*
do
~/bin/hmmer-3.3.1/src/hmmbuild HMM$file $file
done

# for loop to search sequence for conserved mcrA and HSP70 genes


