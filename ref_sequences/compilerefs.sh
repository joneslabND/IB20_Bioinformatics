#Usage: bash compilehsp.sh ReferencesToCompile NameForCompiledFile
#compile the reference sequences for genes
for reference in $1
do
echo $reference
cat $reference >> $2.txt
done
