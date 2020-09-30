# finds proteomes that have hsp70 gene
# usage: bash hsp70proteomes.sh

grep -v "#" *.hsp70 | grep -o "^proteome_[0-9][0-9]" | sort | uniq > hsp70proteomes.txt
