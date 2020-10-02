#Identifying candidate translated genomes based on reference sequences
#Usage: bash finalscript.sh pathtotoolsdirectory

cd ref_sequences

# Create markov model for hsp gene 

cat hsp*.fasta >> hspgenefull.fasta
"$1"/muscle -in hspgenefull.fasta -out hspgenemuscle.txt
"$1"/bin/hmmbuild hspgenehmmr.txt hspgenemuscle.txt 

# Create markov model for mcrA gene
cat mcrA*.fasta >> mcrAgenefull.fasta
"$1"/bin/muscle -in mcrAgenefull.fasta -out mcrAgenemuscle.txt
"$1"/bin/hmmbuild mcrAgenehmmr.txt mcrAgenemuscle.txt

#Execute searches for both genes
cd ../proteomes
mkdir proteomeshsp
mkdir proteomemcrA

cd proteomeshsp
for file in *.fasta
do
"$1"/bin/hmmsearch --tblout proteomeshsp/hsp$file.txt ../ref_sequences/hspgenehmmr.txt $file
done

cd ../proteomesmcrA

for file in *.fasta
do
"$1"/bin/hmmsearch --tblout proteomemcrA/mcrA$file.txt ../ref_sequences/mcrAgenehmmr.txt $file
done 

#Search each proteome for hsp and mcrA markov models

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
cat arrangedcountsforallgenes.txt | sed 's/hspproteome/proteome/g' | cut -d , -f 1,2,4 | sed 's/,/ /g' | sed 's/.fasta.txt/ /g' >> finalresults.txt

#Make candidate results file
echo proteome, hsp, mcrA >> candidatemethanogens.txt
grep -v " 0" finalresults.txt >> candidatemethanogens.txt
