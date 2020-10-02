# code for running muscle to align both Hsp and mcrA sequence files
# need to be in ref_sequences directory to run, output will appear one directory above
# don't forget to input your own file path to muscle!
# usage: bash alignment_fasta.sh 

for file in ref_sequences
do
cat *hsp70gene* "$file" >>  combined_Hsp.fasta
cat *mcrAgene* "$file"  >>  combined_mcrA.fasta
done

for file in combined_mcrA.fasta
do
/afs/crc.nd.edu/user/e/ealeksa2/Private/bin/muscle -in $file -out ../mcrA.aligned
done

for file in combined_Hsp.fasta
do
/afs/crc.nd.edu/user/e/ealeksa2/Private/bin/muscle -in $file -out ../Hsp70.aligned
done
