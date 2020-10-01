#Usage: bash compilehsp.sh hspGeneFiles mcrAGeneFiles
# Compile the reference sequences for the hsp proteins
# Edit this section to change which genes to look for
for reference in $1
do
echo $reference
cat $reference >> aligned_hsp_refs.txt
done

# Compiles the reference sequences for the mcrA gene
# Edit or comment this section if you want to change which genes to look for
for reference2 in $2
do
cat $reference2 >> aligned_mcrA_refs.txt
done
