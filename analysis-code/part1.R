load('withScores.RData')

#Summary statistics
graduate=0
for (i in 1:length(withScores)){
	data <- withScores[[i]]
	graduate <- graduate + length(which(data$GraduateBin==1))
}
graduate/(40*length(data$GraduateBin))

#Noncognitive standardized regression
est <- c()
vars <- c()
intercept <- c()
for (i in 1:length(withScores)){
	stNonCog <- scale(withScores[[i]]$nonCog, center=TRUE, scale=TRUE)
	
	regression<-glm(withScores[[i]]$GraduateBin~stNonCog, family="binomial")
	est[i] <- summary(regression)$coef[[2]]			#est
	vars[i]<-(summary(regression)$coef[[4]])^2		#within-variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
pt(-abs(qHat/overallSE), df=d.f)*2

exp(qHat)

exp(mean(intercept))/(1+exp(mean(intercept)))
exp(mean(intercept+qHat))/(1+exp(mean(intercept+qHat)))
exp(mean(intercept-qHat))/(1+exp(mean(intercept-qHat)))

#Cognitive standardized regression
est <- c()
vars <- c()
intercept <- c()
cogIndices <- which(names(withScores[[1]]) == "Q3LW_SS"):which(names(withScores[[1]]) == "Q3AP_SS")
for (i in 1:length(withScores)){
	dataset <- withScores[[i]]	
	cog <- rowSums(dataset[,cogIndices])/length(cogIndices)
	stCog <- scale(cog)
	withScores[[i]]$stCog <- stCog
	regression<-glm(dataset$GraduateBin~stCog, family="binomial")
	
	intercept[i] <- summary(regression)$coef[[1]]	
	est[i] <- summary(regression)$coef[[2]]			#est
	vars[i]<-(summary(regression)$coef[[4]])^2		#variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
pt(-abs(qHat/overallSE), df=d.f)*2

exp(qHat)

#Size-adjusted Income
est <- c()
vars <- c()
intercept <- c()
for (i in 1:length(withScores)){
	dataset <- withScores[[i]]	
	stIncome <- scale(dataset$fiasMean)
	regression<-glm(dataset$GraduateBin~stIncome, family="binomial")

	intercept[i] <- summary(regression)$coef[[1]]	
	est[i] <- summary(regression)$coef[[1]]			#est
	vars[i]<-(summary(regression)$coef[[3]])^2		#variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
pt(-abs(qHat/overallSE), df=d.f)*2

exp(qHat)

exp(mean(intercept))/(1+exp(mean(intercept)))
exp(mean(intercept+qHat))/(1+exp(mean(intercept+qHat)))
exp(mean(intercept-qHat))/(1+exp(mean(intercept-qHat)))

##Code race and gender
for (i in 1:length(withScores)){
	withScores[[i]]$CHRACE[!(withScores[[i]]$CHRACE %in% c(1,2))] <- 3
	withScores[[i]]$CHRACE <- as.factor(withScores[[i]]$CHRACE)
	withScores[[i]]$ER32000 <- as.factor(withScores[[i]]$ER32000)
	withScores[[i]]$BIOPR97[withScores[[i]]$BIOPR97 == 0] <- NA
}

#Controlling
est <- c()
vars <- c()
intercept <- c()
for (i in 1:length(withScores)){
	data <- withScores[[i]]
	stNonCog <- scale(data$nonCog, center=TRUE, scale=TRUE)
	stIncome <- scale(data$fiasMean)
	data$race <- 1
	data$race[data$CHRACE %in% c(2,3)] <- 2
	
	regression<-glm(data$GraduateBin~stNonCog+stIncome+data$ER32000+data$CHRACE+data$BIOPR97+data$ER11766, family="binomial")
	est[i] <- summary(regression)$coef[[9]]			#est
	vars[i]<-(summary(regression)$coef[[18]])^2		#within-variance
}
qHat=mean(est)
uHat=mean(vars)
B=var(est)
T=uHat+(1+1/40)*B
overallSE = sqrt(T)
d.f = (39)*(1+(40*uHat)/(41*B))^2
