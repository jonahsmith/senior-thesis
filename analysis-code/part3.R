load('withScores.RData')

#code race, gender, biological parents
for (i in 1:length(withScores)){
	withScores[[i]]$CHRACE[!(withScores[[i]]$CHRACE %in% c(1,2))] <- 3
	withScores[[i]]$CHRACE <- as.factor(withScores[[i]]$CHRACE)
	withScores[[i]]$ER32000 <- as.factor(withScores[[i]]$ER32000)
	withScores[[i]]$BIOPR97[withScores[[i]]$BIOPR97 == 0] <- NA
}

#gender separated

data<-withScores[[1]]

est <- c()
vars <- c()
intercept <- c()
for (i in 1:length(withScores)){
	data <- withScores[[i]]
	data <- data[data$ER32000 == 1,]
	stNonCog <- scale(data$nonCog, center=TRUE, scale=TRUE)
	stIncome <- scale(data$fiasMean)
	
	regression<-glm(data$GraduateBin~stNonCog+stIncome+data$CHRACE+data$BIOPR97+data$ER11766+data$Q3LW_SS, family="binomial")
	est[i] <- summary(regression)$coef[[2]]			#est
	vars[i]<-(summary(regression)$coef[[10]])^2		#within-variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
pt(-abs(qHat/overallSE), df=d.f)*2
qHat
overallSE

pnorm(-(0.352756-0.1971543)/sqrt(0.1040697^2 + 0.1019209^2))*2

##race separated (White/non-white)
est <- c()
vars <- c()
intercept <- c()
for (i in 1:length(withScores)){
	data <- withScores[[i]]
	data <- data[data$CHRACE == 1,]
	stNonCog <- scale(data$nonCog, center=TRUE, scale=TRUE)
	stIncome <- scale(data$fiasMean)
	
	regression<-glm(data$GraduateBin~stNonCog+stIncome+data$ER32000+data$BIOPR97+data$ER11766+data$Q3LW_SS, family="binomial")
	est[i] <- summary(regression)$coef[[2]]			#est
	vars[i]<-(summary(regression)$coef[[9]])^2		#within-variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
pt(-abs(qHat/overallSE), df=d.f)*2
qHat
overallSE

pnorm((0.2251235-0.3052591)/sqrt(0.1179516^2 + 0.09941907^2))*2