for file in proteome_{01..50}.fasta
do
match1=$(cat hsp70_$file | grep -v '#' | wc -l) 
match2=$(cat mcrA_$file | grep -v '#' | wc -l)
echo "$file $match1 $match2" | sed 's/.fasta//g'
done
