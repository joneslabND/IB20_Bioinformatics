#usage: bash Me-phresistance ref seq combo files for Hsp90 and McrA genes. Lets us id matches in 
#experimental proteomes
# Identifying methanogens by isolating the methyl-coenzyme M reductase
#(McrA) gene, which catalyzes the last step of methanogenesis and is highly conserved across all
#methanogens. Also identifying pH resistance by isolating the number of copies of the HSP70 gene,
#which is involved in protein biogenesis and refolding for stress resistance.

#generate combined reference sequence files by using cat with all of the .fasta files for Hsp70 and McrA respectively
#cat hsp70gene_01.fasta  hsp70gene_02.fasta  hsp70gene_03.fasta  hsp70gene_04.fasta  hsp70gene_05.fasta  hsp70gene_06.fasta  #hsp70gene_07.fasta  hsp70gene_08.fasta  hsp70gene_09.fasta  hsp70gene_10.fasta  hsp70gene_11.fasta  hsp70gene_12.fasta  #hsp70gene_13.fasta hsp70gene_14.fasta hsp70gene_14.fasta  hsp70gene_15.fasta  hsp70gene_16.fasta  hsp70gene_17.fasta  #hsp70gene_18.fasta  hsp70gene_19.fasta  hsp70gene_20.fasta  hsp70gene_21.fasta  > hsp70gene_combined.fasta  
#cat mcrAgene_01.fasta mcrAgene_02.fasta mcrAgene_03.fasta mcrAgene_04.fasta mcrAgene_05.fasta mcrAgene_06.fasta #mcrAgene_07.fasta mcrAgene_08.fasta mcrAgene_09.fasta mcrAgene_10.fasta mcrAgene_11.fasta mcrAgene_12.fasta mcrAgene_13.fasta #mcrAgene_14.fasta mcrAgene_15.fasta mcrAgene_16.fasta mcrAgene_17.fasta mcrAgene_18.fasta > mcrAgene+combined.fasta



#../muscle -in referencefile -out alignment.afa
#(this will stay the same except we will probably have to change the reference sequence we are 
#looking at)

#../hmmbuild modelresults alignment being used
#(this will stay the same except we will probably have to change the file name for the models we 
#build)  

#../hmmsearch --tblout 3mcrsearch.afa HMMmodelmcr.afa ../proteomes/proteome_03.fasta
#../hmmsearch --tblout 2mcrsearch.afa HMMmodelmcr.afa ../proteomes/proteome_02.fasta
#(the output file will always change, the model being used will come from the result of hmmbuild
#of the specific alignment and the path I used is from the tool directory to the proteomes
#directory)

mkdir hsp70searches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout hsp70searches/$proteome.hsp70txt hsp70outputs/HMMmodelhsp70gene.afa proteomes/$proteome
cd proteomes
done

#echo "proteome, number of matches" >>hsp70matches.txt
cd ../hsp70searches
for proteomefile in *fasta.hsp70txt
do
var1=`cat $proteomefile | grep ^WP_ | wc -l` 
cd ..
echo "$proteomefile, $var1" >>hsp70matches.txt
cd hsp70searches
done

cd ..
mkdir mcrasearches
cd proteomes
for proteome in *.fasta
do
cd ..
~/hmmsearch --tblout mcrasearches/$proteome.mcratxt mcraoutputs/HMMmodelmcr.afa proteomes/$proteome
cd proteomes
done
 
#echo proteome, number of matches >mcramatches.txt
cd ../mcrasearches
for proteomefile in *fasta.mcratxt
do
var2=`cat $proteomefile | grep ^WP_ | wc -l`
cd ..
echo "$proteomefile, $var2" >>mcramatches.txt
cd mcrasearches
done

cd ..
cut -d "," -f 2 mcramatches.txt | paste -d, hsp70matches.txt - | sed 's/.fasta.hsp70txt//' > finalmatches.txt  

cat finalmatches.txt | grep -v " 0" | cut -d "," -f 1 | sed 's/.fasta.hsp70txt//' > finalproteomelist.txt

