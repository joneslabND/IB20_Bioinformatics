# aligns compiled refseqs with muscle
# make sure path to muscle is correct
# bash align.sh 1-compiled-refseqs 2-new-aligned-name in ref_sequences directory

~/Bin/muscle -in "$1" -out "$2"
