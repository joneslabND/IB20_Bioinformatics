# This is the final script for the Bioinformatics project
# Usage: bash final_script.sh
#run from ~/Private/IB20_Bioinformatics/results

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

# This part runs an hmmsearch
# DOES NOT WORK AT THE MOMENT

rm -r mcrA_results
rm -r hsp_results
mkdir mcrA_results
mkdir hsp_results
mv ../proteomes/*.fasta .
for proteome in *.fasta
do
#proteome=$(echo ${variable} | cut -d / -f 3 | cut -d . -f 1)
~/bin/hmmer/bin/hmmsearch aligned_hsp_refs_profile.hmm "$proteome" >> $proteome.txt
~/bin/hmmer/bin/hmmsearch aligned_mcrA_refs_profile.hmm "$proteome" >> $proteome.txt
done

echo "All done!!"
