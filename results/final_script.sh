# This is the final script for the Bioinformatics project
# Your muscle tool should be in the folder ~/bin/<muscletool>
# Your hmmer tools should be in the folder ~/bin/hmmer/bin/<hmmertool>
# Usage: bash final_script.sh

# Compile the reference sequences for the hsp proteins
# Edit this section to change which genes to look for
for reference in ../ref_sequences/"hsp70gene_*.fasta"
do
echo $reference
cat $reference >> compiled_hsp.txt
done

# Compiles the reference sequences for the mcrA gene
# Edit or comment this section if you want to change which genes to look for
for reference2 in ../ref_sequences/"mcrAgene_*.fasta"
do
cat $reference2 >> compiled_mrcA.txt
done

# Runs both of the compiled reference sequences through muscle to set them up
# for the next step
~/bin/muscle -in compiled_mrcA.txt -out aligned_mcrA_refs.txt
~/bin/muslce -in compiled_hsp.txt -out aligned_hsp_refs.txt

# This part uses the tool hmmbuild to align the sequences for the different proteins. It's split into two lines so
# that it creates a search image for the hsp proteins and mrcA proteins
~/bin/hmmer/bin/hmmbuild ./aligned_hsp_refs_profile.hmm ./aligned_hsp_refs.txt
~/bin/hmmer/bin/hmmbuild ./aligned_mcrA_refs_profile.hmm ./aligned_mcrA_refs.txt

# This part runs an hmmsearch
# DOES NOT WORK AT THE MOMENT

~/bin/hmmer/bin/hmmsearch --tblout resultsfile.txt aligned_hsp_refs_profile.hmm compiled_proteomes.txt
