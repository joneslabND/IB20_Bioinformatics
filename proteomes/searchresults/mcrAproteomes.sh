# find all proteomes with mcrA gene and write to a file
# usage: bash mcrAproteomes.sh

grep -v "#" *.mcrA | grep -o "^proteome_[0-9][0-9]" | sort | uniq > mcrAproteomes.txt
