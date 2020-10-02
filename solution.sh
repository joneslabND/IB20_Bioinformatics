#Bio Informatics Project

#Assume we are in the IB20_Bioinformatics Directory in the home of your crc
#Hmmr and Muscle should be located in the bin of the home of your crc

#Combining all the hsp70 gene sequences into one file

for file in ref_sequences/hsp*.fasta
do

cat $file >> hsp_combined_sequence.txt

done

#Aligning the Sequence Using Muscle

../bin/muscle3.8.31_i86linux64 -in hsp_combined_sequence.txt -out muscle_result_hsp

#Creating a profile from hmmer

../bin/hmmr/hmmbuild hmmr_profile_hsp muscle_result_hsp

#Creating a directory for hmmr search results

mkdir hmmr_search_results_hsp

#Creating the search files for hsp in each proteome

cd proteomes
 
for file in *.fasta

do

../../bin/hmmr/hmmsearch --tblout ../hmmr_search_results_hsp/hsp_search_$file ../hmmr_profile_hsp $file

done

cd ..


#Now doing the Same for the McAgene. Combining the sequences to one file

for file in ref_sequences/mcr*.fasta
do
cat $file >> mcr_combined_sequence.txt
done

#Alignment Using Muscle 

../bin/muscle3.8.31_i86linux64 -in mcr_combined_sequence.txt -out muscle_result_mcr

#Creating a profile from hmmer

../bin/hmmr/hmmbuild hmmr_profile_mcr muscle_result_mcr

#Creating a directory for hmmr search results

mkdir hmmr_search_results_mcr

#Creating the search files for msr in each proteome

cd proteomes

for file in *.fasta

do 

../../bin/hmmr/hmmsearch --tblout ../hmmr_search_results_mcr/mcr_search_$file ../hmmr_profile_mcr $file

done

cd ..

#Creating a summary table

echo Proteome Name HSP 70 McrA >> summary_table.txt

cd proteomes

for file in *.fasta

do

HSP=$(grep "WP" ../hmmr_search_results_hsp/hsp_search_$file | wc -l)
MCR=$(grep "WP" ../hmmr_search_results_mcr/mcr_search_$file | wc -l)

echo $file $HSP $MCR >> ../summary_table.txt

done

cd ..

#Creating text file with all proteomes that contain a copy of mcrA and hsp70

grep -E '.fasta [1-9] [1-9]' summary_table.txt | cut -d . -f 1 > candidate_methanogens.txt
