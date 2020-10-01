#This script can be used to align reference proteome files that conatin two specific genes with an 
#entire proteome sequence, build a model for that alignment, and then use that model to search for
#matches. These matches will tell you whether or not the proteomes will carry both of the genes you
#are looking for. 

#usage: bash 

#We created two separate directories to hold the results from using the Bioinformatics tools of 
#muscle and hmmr (build and search). The files contained in those will be used in a for loop that
#will produce a file that will only contain the proteome files that have matches in both genes of 
#interest.
mkdir hsp70outputs
mkdir mcraoutputs

#Within these directories, we ran the muscle tool and hmmr tools to produce all of our outputs that
#we need to go into our for loop as inputs.


