#Short script to clean the files and directories created by solution.sh

rm hmmer_profile_*
rm -r hmmer_search_results_*
rm $1_combined_sequence.txt
rm $2_combined_sequence.txt
rm muscle_result_*
rm summary_table.txt
rm candidate_methanogens.txt
