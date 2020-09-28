
var=1;

for file in ref_sequences/hsp*.fasta
do
	../../bin/muscle -in $file -out hsp$var
	var=$((var+1))
done

var=1;
for file in ref_sequences/mcr*.fasta
do 
        ../../bin/muscle -in	$file -out mcr$var
        var=$((var+1))
done

	
