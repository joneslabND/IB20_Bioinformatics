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

# search proteomes for mcrA image and hsp70 image
for file in proteomes/proteome_*.fasta
do
~/Private/bin/bin/hmmsearch --tblout mcrAresults.fasta mcrAsearchimage.hmm $file
~/Private/bin/bin/hmmsearch --tblout hsp70results.fasta hsp70searchimage.hmm $file
done

# count hits
