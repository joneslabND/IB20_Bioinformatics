#Sorts the best matches with the McrA gene

echo -e "Proteome # , hsp genes , mcrA genes" >> bestmatches.txt
cat table.txt | sort -n -k 6n | tail -n 16 | sort -n -k 4n | tail -n 15 >> bestmatches.txt
