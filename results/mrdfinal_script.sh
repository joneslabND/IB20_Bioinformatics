# This is the final script for the Bioinformatics project
# Usage: bash final_script.sh
#run from ~/Private/IB20_Bioinformatics/results
#Adjust the path to hmmer to reflect your machine's

# Compile the reference sequences for the hsp proteins
# Edit this section to change which genes to look for
rm compiled_hsp.txt
for reference in ../ref_sequences/"hsp70gene_*.fasta"
do
echo $reference
cat $reference >> compiled_hsp.txt
done

# Compiles the reference sequences for the mcrA gene
# Edit or comment this section if you want to change which genes to look for
rm compiled_mcrA.txt
for reference2 in ../ref_sequences/"mcrAgene_*.fasta"
do
cat $reference2 >> compiled_mrcA.txt
done

# Runs both of the compiled reference sequences through muscle to set them up
# for the next step
~/bin/muscle -in compiled_mrcA.txt -out aligned_mcrA_refs.txt
~/bin/muscle -in compiled_hsp.txt -out aligned_hsp_refs.txt

# This part uses the tool hmmbuild to make a Hidden Markov Model for the different proteins. It's split into two lines so
# that it creates a search image for the hsp proteins and mrcA proteins
~/bin/hmmer/bin/hmmbuild ./aligned_hsp_refs_profile.hmm ./aligned_hsp_refs.txt
~/bin/hmmer/bin/hmmbuild ./aligned_mcrA_refs_profile.hmm ./aligned_mcrA_refs.txt

# This part runs an hmmsearch on each proteome using the search image built in the last step
#The results are saved in a folder unique to each gene for potential further use

rm -r mcrA_results
rm -r hsp_results
mkdir mcrA_results
mkdir hsp_results
cp ../proteomes/*.fasta .
for proteome in *.fasta
do
~/bin/hmmer/bin/hmmsearch --tblout ./hsp_results/hsp.$proteome.txt aligned_hsp_refs_profile.hmm "$proteome"
~/bin/hmmer/bin/hmmsearch --tblout ./mcrA_results/mcrA.$proteome.txt aligned_mcrA_refs_profile.hmm "$proteome"
done
rm *.fasta

#This part makes a table with the number of hits each proteome has for each gene
#Hits are saved in a csv with the following format: Proteome_Name,mcrA_Hits,hsp_Hits
echo "Proteome_Name	mcrA_Hits	hsp_Hits" >> output_table.txt
cp ./mcrA_results/mcrA.*.fasta.txt .
for file in mcrA.*.fasta.txt
do
name=$(echo $file | cut -d . -f 2)
mcrAcounts=$(cat $file | grep -v -E "\#" | wc -l)
echo "$name	$mcrAcounts" >> mcrAtable.txt
done

cp ./hsp_results/hsp.*.fasta.txt .
for file in hsp.*.fasta.txt
do
hspcounts=$(cat $file | grep -v -E "\#" | wc -l)
echo $hspcounts >> hsptable.txt
done

paste mcrAtable.txt hsptable.txt >> output_table.txt 

#This part cleans up the mess from earlier so only the important files remain
rm compiled_*
rm aligned_*
rm *.fasta.txt
rm mcrAtable.txt
rm hsptable.txt

echo "All done!!"
