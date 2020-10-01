# start in IB20_Bioinformatics directory
# usage: 
# output:
mkdir working_files

cd ref_sequences

for sequence in mcrA*
do
cat $sequence >> ../working_files/mcrAsequences.fasta
done

for sequence in hsp70*
do
cat $sequence >> ../working_files/hsp70sequences.fasta
done 

#create a proteomedatabase with all 50 proteomes
cd../proteomes
for number in {01..50}; do cat proteome_$number.fasta | sed "s/>/>proteome_$number/g" >> proteomedatabase.fasta; done

cd ../working_files

../../bin/./muscle -in mcrAsequences.fasta -out mcrAgenefull_alignment
../../bin/./hmmbuild mcrAgene_build mcrAgenefull_alignment
../../bin/./hmmsearch --tblout mcrA_match.tbl mcrAgene_build proteomedatabase.fasta 

# need to get results from mcrA into file that hmmer can read
../../bin/muscle -in hsp70sequences.fasta -out hsp70genefull_alignment
../../bin/hmmbuild hsp70gene_build hsp70genefull_alignment
../../bin/hmmsearch --tblout hsp70_match.tbl hsp70gene_build [[[[[results from mcrA]]]

# create files with candidates for each gene
grep -v "#" mcrA_match.tbl | cut -d " " -f 1 | tr -d "WP" >> mcrAcandidates.txt
grep -v "#" hsp70_match.tbl | cut -d " " -f 1 | tr -d [WNY]P >> hsp70candidates.txt

# compare files to see which proteomes contain both genes
grep -f mcrAcandidates.txt hsp70candidates.txt | sort | uniq >> FinalCandidates.txt 

