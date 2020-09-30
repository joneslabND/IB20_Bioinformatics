#Compile all parts of the hsp gene together
#usage: bash scripthsp.sh
cat hsp* > hspgene.txt 
grep -v "RecName" hspgene.txt | tr -d "\n" >> hspgenefull.txt

cat mcrA* > mcrAgene.txt
grep -v "alpha" mcrAgene.txt | tr -d "\n" >> mcrAgenefull.txt

