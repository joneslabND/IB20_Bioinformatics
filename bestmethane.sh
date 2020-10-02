# Analyzes 50 proteomes for conserved mcrA gene for methoanogenesis and HSP70 gene for pH resistance and puts summary in table in text file

# usage: bash bestmethane.sh

# must be in IB_20Bioinformatics directory

# puts all mcrAgenes and hsp70 genes into one file

cat ref_sequences/mcrAgene* > allmcrA.fasta
cat ref_sequences/hsp* > allhsp.fasta

# find aligned sequences in hsp and mcrA

~/bin/muscle -in allhsp.fasta -out alignedhsp.fasta

~/bin/muscle -in allmcrA.fasta -out alignedmcrA.fasta

# HMMbuild match conserved sequences

~/bin/hmmer-3.3.1/bin/hmmbuild hspHMM.fasta alignedhsp.fasta

~/bin/hmmer-3.3.1/bin/hmmbuild mcrAHMM.fasta alignedmcrA.fasta

# moves proteome files into current working directory

mv proteomes/proteome* .

# for loop to search sequence for conserved mcrA and HSP70 genes

for file in proteome* 
do 
~/bin/hmmer-3.3.1/bin/hmmsearch --tblout tables$file mcrAHMM.fasta $file
~/bin/hmmer-3.3.1/bin/hmmsearch --tblout table$file hspHMM.fasta $file
done

#for loop for hsp files

for result in tableproteome*
do
	Number=$(echo $result | cut -d _ -f 2 | cut -d "." -f 1)
	myvar=$(cat $result | grep -v -E "\#"| wc -l)
	echo "$Number	$myvar" >> Hits1.txt		
done

#for loop for mcrA result file

for result in tablesproteome*
do
	Number=$(echo $result | cut -d _ -f 2 | cut -d "." -f 1)
        myvar=$(cat $result | grep -v -E "\#"| wc -l)
        echo "$myvar" >> Hits2.txt
done

#combine tables from mcrA hits and hsp hits into one file for total results

paste Hits1.txt Hits2.txt > totalresults.txt

# sort according to best match to get candidates for pH resistant methanogens

cat totalresults.txt | grep -v 0$ | grep -v "0	" | sort -n -r -k 2 >> precandidates.txt

#make columns at the top

awk 'BEGIN{print "proteome    hsp    mcrA"}{print}' precandidates.txt >> candidates.txt 
