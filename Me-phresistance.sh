#usage: bash Me-phresistance ref seq combo files for Hsp90 and McrA genes. Lets us id matches in experimental proteomes
# Identifying methanogens by isolating the methyl-coenzyme M reductase
#(McrA) gene, which catalyzes the last step of methanogenesis and is
# highly conserved across all methanogens.
# Also identifying pH resistance by isolating the number of copies of the HSP70
# gene, which is involved in protein biogenesis and refolding for stress
# resistance.


../muscle -in referencefile -out alignment.afa
(this will stay the same except we will probably have to change the reference sequence we are 
looking at)

../hmmbuild modelresults alignment being used
(this will stay the same except we will probably have to change the file name for the models we 
build)  

../hmmsearch --tblout 3mcrsearch.afa HMMmodelmcr.afa ../proteomes/proteome_03.fasta
../hmmsearch --tblout 2mcrsearch.afa HMMmodelmcr.afa ../proteomes/proteome_02.fasta
(the output file will always change, the model being used will come from the result of hmmbuild
of the specific alignment and the path I used is from the tool directory to the proteomes
directory)
