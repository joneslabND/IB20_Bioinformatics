
var=1;
var2=1;

for file in ref_sequences/hsp*.fasta
do
	../../bin/muscle -in $file -out hsp$var
	../../bin/hmmbuild hspBuild$var hsp$var
 	for proteome in proteomes/*.fasta
        do
          	../../bin/hmmsearch --tblout hsp${var}Prot${var2}Table hspBuild$var $proteome
                var2=$((var2+1))
        done
	var=$((var+1))
        var2=1;
done

var=1;
for file in ref_sequences/mcr*.fasta
do 
        ../../bin/muscle -in	$file -out mcr$var
	../../bin/hmmbuild mcrBuild$var mcr$var        
	var=$((var+1))

done
