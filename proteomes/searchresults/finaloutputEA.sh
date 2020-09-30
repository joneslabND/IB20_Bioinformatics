# looks at all files in searchresults directory and sorts out lines containing gene 
# hits (for mcrA or hsp70)and parent fasta names
# note: can ommit -e "# Target file:" if you just want the lines containing gene hits 

for file in *.mcrA
do
cat $file | grep -E -e "mcrA" -e "# Target file:" | sort | uniq >> mcrAproteome_hits.txt
done 


for file in *.hsp70
do
cat $file | grep -E -e "hsp70" -e "# Target file:" | sort | uniq >> Hsp70proteome_hits.txt
done





