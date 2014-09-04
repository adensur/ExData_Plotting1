##This script loads the data from the file household_power_consumption.txt,
##which should be located in R working directory.
##it creates a plot named plot4.png

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
png("plot4.png")       
##the default function png() actually has all the correct params, like height and width

par(bg=NA)         ##Background will be transparent
par(mfrow=c(2,2))  ##Set the number of row/columns for plots

##First plot is equal to plot2.png:
with(data,plot(Date, Global_active_power,type="l",
               xlab="",ylab="Global Active Power (kilowatts)"))

##Second plot - Voltage ~ datetime scatterplot with points connected with lines
with(data,plot(Date, Voltage,type="l",
               xlab="datetime",ylab="Voltage"))

##Third plot - same as plot3.png, with a little difference - 
## - there is now no border around the legend (parameter bty="n")
with(data,plot(Date, Sub_metering_1,type="l",
               xlab="",ylab="Energy sub metering"))
with(data,lines(Date, Sub_metering_2,col="red"))
with(data,lines(Date, Sub_metering_3,col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1),bty="n")

#Fourth plot - Global reactive power ~ datetime.
with(data,plot(Date, Global_reactive_power,type="l",
               xlab="datetime",ylab="Global_reactive_power"))

dev.off()
