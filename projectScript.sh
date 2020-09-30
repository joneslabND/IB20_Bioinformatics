
var=1;

for file in ref_sequences/hsp*.fasta
do
	../../bin/muscle -in $file -out hsp$var
	../../bin/hmmbuild hspBuild$var hsp$var
	var=$((var+1))
done

var=1;
for file in ref_sequences/mcr*.fasta
do 
        ../../bin/muscle -in	$file -out mcr$var
	../../bin/hmmbuild mcrBuild$var mcr$var        
	var=$((var+1))

done
