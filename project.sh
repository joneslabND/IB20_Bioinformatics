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
cd ../proteomes
for number in {01..50}; do cat proteome_$number.fasta | sed "s/>/>proteome_$number/g" >> proteomedatabase.fasta; done

cd ../working_files

#find proteomes with mcrA gene matches
../../bin/./muscle -in mcrAsequences.fasta -out mcrAgenefull_alignment
../../bin/./hmmbuild mcrAgene_build mcrAgenefull_alignment
../../bin/./hmmsearch --tblout mcrA_match.tbl mcrAgene_build ../proteomes/proteomedatabase.fasta 

# find proteomes with hsp70 gene matches
../../bin/muscle -in hsp70sequences.fasta -out hsp70genefull_alignment
../../bin/hmmbuild hsp70gene_build hsp70genefull_alignment
../../bin/hmmsearch --tblout hsp70_match.tbl hsp70gene_build ../proteomes/proteomedatabase.fasta

# create text  files with candidates for each gene
grep -v "#" mcrA_match.tbl | cut -d "_" -f 1,2 | tr -d "WP" >> mcrAcandidates.txt
grep -v "#" hsp70_match.tbl | cut -d "_" -f 1,2 | tr -d [WNY]P >> hsp70candidates.txt

# compare files to see which proteomes contain both genes and create a text final with pH resistant methanogens
grep -f mcrAcandidates.txt hsp70candidates.txt | sort | uniq >> FinalCandidates.txt 

#make a table with summary of all outputs
for number in {01..50} ; do export hsp70var_$number=$(grep -c "proteome_$number" hsp70candidates.txt) ; done
for number in {01..50} ; do export mcrAvar_$number=$(grep -c "proteome_$number" mcrAcandidates.txt) ; done
for number in {01..50} ; do eval echo proteome_$number,\$hsp70var_$number,\$mcrAvar_$number; done >> SummaryTable.txt
sed '1 s/^/proteome,hsp 70 matches,mcrA matches\n/' SummaryTable.txt > FinalSummaryTable.txt 
