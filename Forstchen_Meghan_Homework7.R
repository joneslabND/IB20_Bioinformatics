#Question 1

#R code that replicates the function of "head" in linux
#Load the iris.csv file into R to use as the file to return lines from
#The iris.csv file is saved onto my desktop, so set the working directory to Desktop
setwd("/Users/meghanforstchen/Desktop")
#Load in iris.csv
iris <- read.csv(file = "~/Desktop/iris.csv", header = TRUE, stringsAsFactors = FALSE)
#Replicate the "head" function from linux. I will be getting the first five lines of code from the 
# file iris.csv and printing it to the console.
iris[1:5,]

#Question 2

#Load the iris.csv file into R if not done in "Question 1"
#The iris.csv file is saved onto my desktop, so set the working directory to Desktop
setwd("/Users/meghanforstchen/Desktop")
#Load in iris.csv
iris <- read.csv(file = "~/Desktop/iris.csv", header = TRUE, stringsAsFactors = FALSE)

#Print the last two rows and columns to the terminal
iris[149:150, 4:5]

#Count the observations of each species
#Make dataframes from the "Species" column for each of the species: setosa, veriscolor, and virginica
setosa <- iris[iris$Species == "setosa",]
versicolor <- iris[iris$Species == "versicolor",]
viriginica <- iris[iris$Species == "virginica",]
#Use the nrow function to get the number of observations from each species
#Paste  the phrase "The number of X observations is:"
#This will print the number of observations of each species to the console after the pasted phrase
paste("The number of setosa observations is", nrow(setosa), sep=" ")
paste("The number of versicolor observations is", nrow(versicolor), sep=" ")
paste("The number of virginica observations is", nrow(viriginica), sep=" ")

#Get rows with sepal width above 3.5
sepal_width_3.5 <- iris[iris$Sepal.Width>3.5,]

#Write the data for the species setosa into a csv file
#Create dataframe with just setosa data
setosa <- iris[iris$Species == "setosa",]
#Put this data into a new csv file
write.table(setosa, "setosa.csv", row.names = FALSE, sep=",")

#Calculate the mean, minimum, and maximum of Petal.length for observations from virginica 
#First make a dataframe for virginica
viriginica <- iris[iris$Species == "virginica",]
#Get the Petal Length observations for the species virginica
Petal.length_Virginica <- viriginica[,3]
#Calculate the mean, min, and max values for Petal.length
mean(Petal.length_Virginica)
min(Petal.length_Virginica)
max(Petal.length_Virginica)


