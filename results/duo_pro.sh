# This is the final script for the Bioinformatics project
# This program searches through multiple proteomes to see if two proteins and
# variations of them are present. 
# Usage: bash duo_pro.sh <PathToProtein1References> <PathToProtein2References> <PathToProteomes>
#run from ~/Private/IB20_Bioinformatics/results
#ensure you use the proper path the your machine's hmmer
#Adjust the path to hmmer to reflect your machine's
#do we need to tell you to change the hmmer path again?

#This part compiles the reference sequences for protein1
#It uses the path you provided
rm compiled_protein1.txt
for reference in "$1"
do
echo $reference
cat $reference >> compiled_protein1.txt
done

#This part compiles the reference sequences for protein2
#It uses the path you provided
rm compiled_protein2.txt
for reference2 in "$2"
do
cat $reference2 >> compiled_protein2.txt
done

#This part runs both of the compiled reference sequences through muscle to set them up
# for the next step
~/bin/muscle -in compiled_protein1.txt -out aligned_protein1_refs.txt
~/bin/muscle -in compiled_protein2.txt -out aligned_protein2_refs.txt

# This part uses the tool hmmbuild to make a Hidden Markov Model for the different proteins. It's split into two lines so
# that it creates a search image for each protein
##MAKE SURE YOU USE THE PATH TO HMMER FOR YOUR PERSONAL MACHINE##
~/bin/hmmer/bin/hmmbuild ./aligned_protein1_refs_profile.hmm ./aligned_protein1_refs.txt
~/bin/hmmer/bin/hmmbuild ./aligned_protein2_refs_profile.hmm ./aligned_protein2_refs.txt

# This part runs an hmmsearch on each proteome using the search image built in the last step
#The results are saved in a folder unique to each gene for potential further use
#You must provide the proper path to the proteomes
##MAKE SURE YOU USE THE PATH TO HMMER FOR YOUR PERSONAL MACHINE##
mkdir protein2_results
mkdir protein1_results
cp $3 .
for proteome in *.fasta
do
~/bin/hmmer/bin/hmmsearch --tblout ./protein1_results/protein1.$proteome.txt aligned_protein1_refs_profile.hmm "$proteome"
~/bin/hmmer/bin/hmmsearch --tblout ./protein2_results/protein2.$proteome.txt aligned_protein2_refs_profile.hmm "$proteome"
done

#This part makes a table with the number of hits each proteome has for each protein
#Hits are saved in a tab delimited file with the following format: Proteome_Name,protein2_Hits,protein1_Hits
echo "Proteome_Name	protein2_Hits	protein1_Hits" >> output_table.txt
cp ./protein2_results/protein2.*.fasta.txt .
for file in protein2.*.fasta.txt
do
name=$(echo $file | cut -d . -f 2)
protein2counts=$(cat $file | grep -v -E "\#" | wc -l)
echo "$name	$protein2counts" >> protein2table.txt
done

cp ./protein1_results/protein1.*.fasta.txt .
for file in protein1.*.fasta.txt
do
protein1counts=$(cat $file | grep -v -E "\#" | wc -l)
echo $protein1counts >> protein1table.txt
done

paste protein2table.txt protein1table.txt >> output_table.txt 

#This part provides a list of suitable candidates
#A proteome is considered a suitable candidate if it has one or more copies of protein2 and protein1
#The list is sorted so that the best candidate proteome
#(with the highest number of hits for protein1) is first

cat output_table.txt | awk '$2 != "0"' | awk '$3 != "0"' | sort -k3,3n | cut -f 1 >> sorted_candidate_list.txt 

#This part cleans up the mess from earlier so only the important files remain
rm compiled_*
rm aligned_*
rm *.fasta.txt
rm protein2table.txt
rm protein1table.txt
rm *fasta


echo "All done!!"
