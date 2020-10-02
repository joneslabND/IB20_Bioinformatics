#This shell script is to look for two genes in any target species.
#Arguments within the shell script are as follows $1=hsp70*.fasta reference genes, $2=mcr*.fasta reference genes, $3=proteome*.fasta target genes.
#The output containing target species with both reference genes will be presented in a table.

#We combine all files for gene1 into one fasta file
#Make sure that the directory for your tools hmmr and muscle correspond to your pathway. Ours are located two directories above. 
#We then align the files with muscle
#We then build a regular expression using the tool hmmbuild

for gene in “$1”
do
cat $gene >> gene1.fa
done
../../muscle -in gene1.fasta -out gene1.afa
../../hmmbuild gene1.hmm gene1.afa

#We combine all files for gene2 into one fasta file. 
#Make sure that the directory for your tools hmmr and muscle correspond to your pathway. Ours are located two directories above.
#We then align the files with muscle
#We then build a regular expression using the tool hmmbuild

for gene in "$2"
do
cat $gene >> gene2.fa
done
../../muscle -in gene2.fasta -out gene2.afa
../../hmmbuild gene2.hmm gene2.afa


#First, this loop is for hmm search to generate a table for proteome matches of gene1 and gene2. 

for proteome in "$3”
do
../../hmmsearch --tblout genesOfInterest1.tblout gene1.hmm gene1.afa $proteome | grep ^WP_ | wc -l >> matches1.txt
../../hmmsearch --tblout genesOfInterest2.tblout gene2.hmm gene2.afa $proteome | grep ^WP_ | wc -l >> matches2.txt
done

#We want to put the matches[1,2].txt files into a combined file. However, we need to associated "Target Species" name with each line.
#We generate the table with the names of the "Target Species" with a for loop.

for column in "$3"
do echo $column >> proteomename.txt
done

#We combine all columns into one file.
paste proteomename.txt matches1.txt matches2.txt > matchescombined.txt


#Now we organize our proteome matches to see which targets have the best quality match.
cat matchescombined.txt | grep -v “ 0” | sort -k 2 -n >> finalMatches.csv


