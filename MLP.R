

#
#	part 1: importing data 
#


mydata <- read.csv("C:/loan.csv")

head(mydata)
tail(mydata)
dim(mydata)


#
#	part 2: summarizing data
#

summary(mydata)
apply(mydata, 2, sd)



#
#	part 3: visualizing data
#


hist(mydata$fico, xlab="credit score", col="green", main="histogram of credit score")
plot(mydata$dti, mydata$fico, xlab="debt-to-income ratio", ylab="credit score")
lines(lowess(mydata$dti, mydata$fico), col="red", lwd=2)


#
#	part 4: standardizing data
#


mydata.scaled  <- scale( mydata )

apply(mydata.scaled  , 2, sd)
apply(mydata.scaled  , 2, mean)



#
#	part 5: splitting data
#

train.index <- 0.8 * nrow( mydata.scaled  )
train<- mydata.scaled  [1:train.index , ]
test<-  mydata.scaled  [train.index:nrow( mydata.scaled ),]

tail(train)
head(test)



#
# 	part 6: the package
#


install.packages("neuralnet")
library(neuralnet)
citation("neuralnet")


#
# 	part 7: fitting the  model
#


fit <- neuralnet(fico ~ int.rate + installment + log.annual.inc + dti, 
				data = train, hidden = 2)


plot(fit)




#
# 	part 8: out-of-sample prediction
#

prediction<- predict(fit, newdata=test)




