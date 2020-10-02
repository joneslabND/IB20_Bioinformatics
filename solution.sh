#Bio Informatics Project

#Assume we are in the IB20_Bioinformatics Directory in the home of your crc
#Hmmr and Muscle should be located in the bin of the home of your crc

#Pass Two Arguments when Running solution.sh which are the short names for the genes you are searching for
#For this project, pass hsp and mcr (in that order), but script can be used for other reference sequences

#Combining all the hsp70 gene sequences into one file

for file in ref_sequences/${1}*.fasta
do

cat $file >> ${1}_combined_sequence.txt

done

#Aligning the Sequence Using Muscle

../bin/muscle -in ${1}_combined_sequence.txt -out muscle_result_${1}

#Creating a profile from hmmer

../bin/hmmer/hmmbuild hmmer_profile_${1} muscle_result_${1}

#Creating a directory for hmmr search results

mkdir hmmer_search_results_${1}

#Creating the search files for hsp in each proteome

cd proteomes
 
for file in *.fasta

do

../../bin/hmmer/hmmsearch --tblout ../hmmer_search_results_${1}/${1}_search_$file ../hmmer_profile_${1} $file

done

cd ..


#Now doing the Same for the McAgene. Combining the sequences to one file

for file in ref_sequences/${2}*.fasta
do
cat $file >> ${2}_combined_sequence.txt
done

#Alignment Using Muscle 

../bin/muscle -in ${2}_combined_sequence.txt -out muscle_result_${2}

#Creating a profile from hmmer

../bin/hmmer/hmmbuild hmmer_profile_${2} muscle_result_${2}

#Creating a directory for hmmer search results

mkdir hmmer_search_results_${2}

#Creating the search files for mcr in each proteome

cd proteomes

for file in *.fasta

do 

../../bin/hmmer/hmmsearch --tblout ../hmmer_search_results_${2}/${2}_search_$file ../hmmer_profile_${2} $file

done

cd ..

#Creating a summary table

echo This table will have three columns. >> summary_table.txt

echo The first column is the name of the proteome. >> summary_table.txt

echo The second column is the number of hits for the hsp gene. >> summary_table.txt

echo The third will have the number of hits for the mcr gene. >> summary_table.txt

echo >> summary_table.txt

echo Prot_ Name HSP70 McrA >> summary_table.txt

echo >> summary_table.txt

cd proteomes

for file in *.fasta

do

HSP=$(grep "WP" ../hmmr_search_results_hsp/hsp_search_$file | wc -l)
MCR=$(grep "WP" ../hmmr_search_results_mcr/mcr_search_$file | wc -l)

echo $file $HSP $MCR >> ../summary_table.txt

done

cd ..

echo Check summary_table.txt for results!

#Creating text file with all proteomes that contain a copy of mcrA and hsp70

grep -E '.fasta [1-9] [1-9]' summary_table.txt | cut -d . -f 1 > candidate_methanogens.txt


