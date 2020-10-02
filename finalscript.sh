#Identifying candidate translated genomes based on reference sequences
#Usage: bash finalscript.sh pathtotoolsdirectory
#"pathtotoolsdirectory" as in the pathway to directory that holds 'muscle','hmmbuild',and 'hmmsearch'

cd ref_sequences

# Create markov model for hsp gene 

cat hsp*.fasta >> hspgenefull.fasta
"$1"/muscle -in hspgenefull.fasta -out hspgenemuscle.txt
"$1"/hmmbuild hspgenehmmr.txt hspgenemuscle.txt 

# Create markov model for mcrA gene
cat mcrA*.fasta >> mcrAgenefull.fasta
"$1"/muscle -in mcrAgenefull.fasta -out mcrAgenemuscle.txt
"$1"/hmmbuild mcrAgenehmmr.txt mcrAgenemuscle.txt

#Execute searches for both genes
cd ../proteomes
mkdir proteomeshsp
mkdir proteomemcrA

for file in *.fasta
do
"$1"/hmmsearch --tblout proteomeshsp/hsp$file.txt ../ref_sequences/hspgenehmmr.txt $file
done

for file in *.fasta
do
"$1"/hmmsearch --tblout proteomemcrA/mcrA$file.txt ../ref_sequences/mcrAgenehmmr.txt $file
done 

#Search each proteome for hsp and mcrA markov models

cd proteomemcrA
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
cd ../
cat proteomemcrA/mcrAgenecount.txt proteomeshsp/hspgenecount.txt | sort -k2,2n -t\_ >> countsforallgenes.txt
paste -s -d",\n" countsforallgenes.txt >> arrangedcountsforallgenes.txt

#Make summary table of results of arranged counts
echo "Proteome hspGene mcrAgene" >> finalresults.txt
cat arrangedcountsforallgenes.txt | sed 's/hspproteome/proteome/g' | cut -d , -f 1,2,4 | sed 's/,/ /g' | sed 's/.fasta.txt/ /g' >> finalresults.txt

#Make candidate results file
echo "Proteome hspGene mcrAgene" >> candidatemethanogens.txt
grep -v " 0" finalresults.txt >> candidatemethanogens.txt
mv candidatemethanogens.txt ../
