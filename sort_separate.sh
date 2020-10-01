tail -n 50 summary_table.txt | sort -nr -k 3 -k 2 | head -n 15 | cut -d " " -f 1 | cut -d "." -f 1 > candidate_methanogens.txt
