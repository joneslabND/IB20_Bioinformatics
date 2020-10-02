# start in IB20_Bioinformatics directory
# usage: bash project.sh gene_1 gene_2
# output: proteomes that contain both genes
mkdir working_files

cd ref_sequences

for sequence in "$1"*
do
cat $sequence >> ../working_files/"$1"sequences.fasta
done

for sequence in "$2"*
do
cat $sequence >> ../working_files/"$2"sequences.fasta
done 

#create a proteomedatabase with all 50 proteomes
cd ../proteomes
for number in {01..50}; do cat proteome_$number.fasta | sed "s/>/>proteome_$number/g" >> proteomedatabase.fasta; done

cd ../working_files

#find proteomes with gene_1 matches
../../bin/./muscle -in "$1"sequences.fasta -out "$1"genefull_alignment
../../bin/./hmmbuild "$1"gene_build "$1"genefull_alignment
../../bin/./hmmsearch --tblout "$1"match.tbl "$1"gene_build ../proteomes/proteomedatabase.fasta 

# find proteomes with gene_2 matches
../../bin/muscle -in "$2"sequences.fasta -out "$2"genefull_alignment
../../bin/hmmbuild "$2"gene_build "$2"genefull_alignment
../../bin/hmmsearch --tblout "$2"match.tbl "$2"gene_build ../proteomes/proteomedatabase.fasta

# create text files with candidates for each gene
grep -v "#" "$1"match.tbl | cut -d "_" -f 1,2 | tr -d "WP" > "$1"candidates.txt
grep -v "#" "$2"match.tbl | cut -d "_" -f 1,2 | tr -d [WNY]P > "$2"candidates.txt

# compare files to see which proteomes contain both genes and create a text final with pH resistant methanogens
grep -f "$1"candidates.txt "$2"candidates.txt | sort | uniq > FinalCandidates.txt 

#make a table with summary of all outputs
for number in {01..50} ; do export "$2"var_$number=$(grep -c "proteome_$number" "$2"candidates.txt) ; done
for number in {01..50} ; do export "$1"var_$number=$(grep -c "proteome_$number" "$1"candidates.txt) ; done
for number in {01..50} ; do eval echo proteome_$number,\$"$2"var_$number,\$"$1"var_$number; done >> SummaryTable.txt
sed "1 s/^/proteome,"$2" matches,"$1" matches\n/" SummaryTable.txt > FinalSummaryTable.txt 
