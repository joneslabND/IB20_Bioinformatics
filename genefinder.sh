# general: run in parent directory of proteomes and ref_sequences directory
# usage: bash genefinder.sh 1-compiled-hsp70-refseq-name 2-compiled-mcrA-refseq-name 3-aligned-hsp70 4-aligned-mcrA 5-hsp70-built 6-mcrA-built 7-hsp70-hits 8-mcrA-hits 9-hsp70-and-mcrA-hits 10-candidate-proteomes


# compiles all genes into two files to prep for alignment

for file in ref_sequences/hsp*.fasta
do
cat $file >> $1
done

for file in ref_sequences/mcrA*.fasta
do
cat $file >> $2
done

# outputs from above: hsp70comp.fasta($1) mcrAcomp.fasta($2)

 
# aligns compiled refseqs with muscle
# make sure path to muscle is correct!

~/Bin/muscle -in $1 -out $3
~/Bin/muscle -in $2 -out $4

# outputs from above: hsp70.aligned($3) mcrA.aligned($4)

# builds a HMM profile for each gene alignment
# make sure path to hmmbuild is correct

~/Bin/hmmer/hmmbuild $5 $3
~/Bin/hmmer/hmmbuild $6 $4

# outputs from above: hsp70.built($5) mcrA.built($6)

mkdir searchresults

# search for genes within each proteome, prints results to proteomes directory
# make sure path to hmmbuild results is correct

for pro in proteomes/proteome*.fasta
do
~/Bin/hmmer/hmmsearch --tblout "$pro".hsp70 $5 "$pro"
done

for pro in proteomes/proteome*.fasta
do
~/Bin/hmmer/hmmsearch --tblout "$pro".mcrA $6 "$pro"
done

# moves results from proteomes directory to searchresults directory

mv proteomes/*.hsp70 searchresults
mv proteomes/*.mcrA searchresults

# looks at all files in searchresults directory and prints hits

grep -R -v "#" searchresults/*.hsp70 > $7
grep -R -v "#" searchresults/*.mcrA > $8

# outputs from above: hsp70proteome_hits.txt($7) mcrAproteome_hits.txt($8)

# prints all candidate pH-resistant methanogens into one file

grep -v "#" searchresults/*.hsp70 | grep -o "proteome_[0-9][0-9]" | sort | uniq > $9
grep -v	"#" searchresults/*.mcrA | grep -o "proteome_[0-9][0-9]" | sort | uniq > $10

cat $9 $10 > $11 
cat $11 | sort | uniq -d > CANDIDATES.txt

# outputs from above: allproteomes.txt($9) CANDIDATES.txt($10)

