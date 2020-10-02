# this script uses muscle to align proteome gene sequences
# it then uses hmmer to create a search image for the mcrA gene of methanogens, and the hsp70 gene showing pH resistance
# it outputs results files including tables for both mcrA gene and hsp70 gene matches
# it then cuts and sorts the results to create the file pHresistantProteomes.txt to show which methanogen proteomes have the highest pH resistance

# mcrA total genes file
for file in ref_sequences/mcrAgene*.fasta
do
cat $file >> totalmcrAgene.fasta
done

# create aligned mcrA genes with muscle
~/Private/bin/muscle -in totalmcrAgene.fasta -out alignedmcrAgenes.fasta

# create mcrA gene search image
~/Private/bin/bin/hmmbuild mcrAsearchimage.hmm alignedmcrAgenes.fasta

# hsp70 total genes file
for file in ref_sequences/hsp70gene*.fasta
do
cat $file >> totalhsp70gene.fasta
done

# create hsp70 gene alignment
~/Private/bin/muscle -in totalhsp70gene.fasta -out alignedhsp70genes.fasta

# create hsp70 gene search image
~/Private/bin/bin/hmmbuild hsp70searchimage.hmm alignedhsp70genes.fasta

# make a header for summary file
echo "proteome, mcrA_Hits, hsp70_Hits" > summaryOutput.csv

# search proteomes for mcrA gene search image and hsp70 gene search image
for file in proteomes/proteome_*.fasta
do
name=$(echo $file | cut -d "." -f 1 | cut -d "/" -f 2)
~/Private/bin/bin/hmmsearch --tblout mcrAresults."$name".txt mcrAsearchimage.hmm $file
~/Private/bin/bin/hmmsearch --tblout hsp70results."$name".txt hsp70searchimage.hmm $file
mcrAHits=$(cat mcrAresults."$name".txt | grep -v "#" | wc -l)
hsp70Hits=$(cat hsp70results."$name".txt | grep -v "#" | wc -l)
echo "$name,$mcrAHits,$hsp70Hits" >> summaryOutput.csv
done

# include only proteomes with mcrA genes (methanogens), sort by highest copies of hsp70 gene (pH resistance), store in final text file
cat summaryOutput.csv | sort -t , -n -r -k 2 | head -n 16 | sort -t , -n -r -k 3 >> pHresistantProteomes.txt

