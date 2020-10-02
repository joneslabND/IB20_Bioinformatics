# looks at all files in searchresults directory and sorts out lines containing gene
# hits (for mcrA or hsp70)and parent fasta names
# usage: bash finalout2.sh

grep -R -v "#" *.mcrA > mcrAproteome_hits.txt

grep -R -v "#" *.hsp70 > hsp70proteome_hits.txt

# prints all candidate pH-resistant methanogens into one file

cat hsp70proteomes.txt mcrAproteomes.txt > allproteomes.txt

cat allproteomes.txt | sort | uniq -d > candidates.txt
