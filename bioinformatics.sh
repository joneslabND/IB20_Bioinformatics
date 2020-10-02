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

# search proteomes for mcrA image and hsp70 image
for file in proteomes/proteome_*.fasta
do
name=$(echo $file | cut -d "." -f 1 | cut -d "/" -f 2)
~/Private/bin/bin/hmmsearch --tblout mcrAresults."$name".txt mcrAsearchimage.hmm $file
~/Private/bin/bin/hmmsearch --tblout hsp70results."$name".txt hsp70searchimage.hmm $file
mcrAHits=$(cat mcrAresults."$name".txt | grep -v "#" | wc -l)
hsp70Hits=$(cat hsp70results."$name".txt | grep -v "#" | wc -l)
echo "$name,$,$" >> summaryOutput.csv
done

# count hits
# sort summary, keep non zero in mcra, sort by hsp70
