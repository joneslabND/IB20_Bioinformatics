#Usage:
cd ref_sequences

# Create template for hsp gene 

cat hsp*.fasta >> hspgenefull.fasta
../../bin/muscle -in hspgenefull.fasta -out hspgenemuscle.txt
../../bin/hmmbuild hspgenehmmr.txt hspgenemuscle.txt 

# Create template for mcrA gene
cat mcrA*.fasta >> mcrAgenefull.fasta
../../bin/muscle -in mcrAgenefull.fasta -out mcrAgenemuscle.txt
../../bin/hmmbuild mcrAgenehmmr.txt mcrAgenemuscle.txt

#Execute searches for both genes
cd ../proteomes
mkdir proteomeshsp
mkdir proteomesmcrA

cd proteomeshsp
for file in *.fasta
do
../../bin/hmmsearch --tblout proteomeshsp/hsp$file.txt ../ref_sequences/hspgenehmmr.txt $file
done

cd ../proteomesmcrA

for file in *.fasta
do
../../bin/hmmsearch --tblout proteomemcrA/mcrA$file.txt ../ref_sequences/mcrAgenehmmr.txt $file
done 

#Search for genes

for file in mcrAproteome*.fasta.txt
do
var=$(grep "^WP_" $file | wc -l)
echo $file, $var >> mcrAgenecount.txt
done

cd ../proteomeshsp
for file in hspproteome*.fasta.txt
do
var=$(grep "^WP_" $file | wc -l)
echo $file, $var >> hspgenecount.txt
done

#Compile and arrange counts in one file 
cat proteomemcrA/mcrAcount.txt proteomeshsp/hspcount.txt | sort -k2,2n -t\_ >> countsforallgenes.txt
paste -s -d",\n" countsforallgenes.txt >> arrangedcountsforallgenes.txt

#Make summary table of results of arranged counts
echo "Proteome hspGene mcrAgene" >> finalresults.txt
cat arrangedcountrsforallgenes.txt | sed 's/hspproteome/proteome/g' | cut -d , -f 1,2,4 | sed 's/,/ /g' | sed 's/.fasta.txt/ /g' >> finalresults.txt
