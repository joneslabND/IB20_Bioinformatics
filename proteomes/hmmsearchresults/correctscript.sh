for file in *.fasta
do
match=$(cat $file | grep -v '#' | wc -l)
echo "$file,$match" 
done
