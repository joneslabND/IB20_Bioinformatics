# builds a HMM profile for each gene alignment
# make sure path to hmmbuild is correct
# bash build.sh 1-new-file-name 2-aligned-gene-from-muscle

~/Bin/hmmer/hmmbuild "$1" "$2"
