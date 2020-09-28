#Compile all parts of the hsp gene together
#usage: bash scripthsp.sh
cat hsp* | grep -v "Recname" | tr -d "\n" >> hspgene.txt

