# This is the final script for the Bioinformatics project
# Usage: bash final_script.sh 

# This part uses the tool hmmbuild to align the sequences for the different proteins. It's split into two lines so
# that it creates a profile for the hsp proteins and mrcA proteins
~/bin/hmmer/hmmbuild ~/Private/IB20_Bioinformatics/ref_sequences/aligned_hsp_refs_profile.hmm ~/Private/IB20_Bioinformatics/ref_sequences/aligned_hsp_refs.txt
~/bin/hmmer/hmmbuild ~/Private/IB20_Bioinformatics/ref_sequences/aligned_mcrA_refs_profile.hmm ~/Private/IB20_Bioinformatics/ref_sequences/aligned_mcrA_refs.txt
