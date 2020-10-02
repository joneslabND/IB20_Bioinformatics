#running from proteome directory with hspresults and mcra results being a subdirectory of current location

echo "Proteome # ,  hsp Matches , mcrA Matches" >> table.txt
echo -n >> table.txt
for num in {01..50}
do
echo -e "$(echo "Proteome" $num) " , " $(grep ^"W" ./hspresults/hspsearchoutput_proteome$num.HMM | wc -l) " , " $(grep ^"W" ./mcraresults/mcrasearchoutput_proteome$num.HMM | wc -l)" >> table.txt
echo -n >> table.txt
done
