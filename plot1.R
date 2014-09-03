##This script loads the data from the file household_power_consumption.txt,
##which should be located in R working directory.
##it creates a plot in a subfolder "/my_figures/" named plot1.png

##Step 1. Reading the data. (this part is the same for all 4 plots)

##the rows that contain the data for 2007.02.01 and 2007.02.02 
##are 66637 to 69517, not counting the header.

colclasses<-c("character","character",rep("numeric",times=7)) ##specify the correct col classes for our function to read:

data<-read.table("household_power_consumption.txt",sep=";",header=FALSE,skip=66637,nrows=2880,colClasses=colclasses,dec=".")

##Because we specify "skip", we have to read a file one more time to fetch column names:
colnames(data)<-as.vector(t(read.csv2("household_power_consumption.txt",nrows=1,header=FALSE)))

##Now we concatenate first 2 columns and convert them to POSIXct date/time format:
data[,1]<-paste0(data[,1]," ",data[,2])
data<-data[,-2]
as.POSIXct(data[,1],format="%d/%m/%Y %H:%M:%S")->data[,1]

##Step2.Plot the actual plot.
##First we open a device for plotting into file:
png("plot1.png")       
##the default function png() actually has all the correct params, like height and width

##This is a histogram of Global Active Power data, coloured in red and with extra main label and x label.
with(data,hist(Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.off()