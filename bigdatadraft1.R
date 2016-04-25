#IMPORTING DATA
library(glmnet)
library(lars)
library(gclus)
library(gdata)

#ClEANING
finaldate<- sqldf("select date.dates from date inner join MSFT_tech where MSFT_tech.Date==date.dates")
macrodata<-cbind(date,macrodata)
macrodata$`oil$DATE`<-NULL
macrodata<-sqldf("select * from macrodata inner join finaldate where macrodata.dates==finaldate.dates")


data<-load("/Users/pinankshah/Downloads/X.RData")
oilloc <- "/Users/pinankshah/Downloads/oil.csv"
oil <- read.csv(oilloc, header=TRUE, stringsAsFactors= FALSE)

for(i in 1:2)
{
  row<-which(oil$oil==".")
  row1<-row-1
  oil$oil[row]<-oil$oil[row1]
}
oil$oil<-as.numeric(oil$oil)
oil$oil<-scale(oil$oil,center=TRUE)

dat<-data
dat$eurusd<-X$eurusd
dat$ftse<-X$ftse$X5681.5
dat$nasd<-X$nasdaq$X1679.93
dat$sp<-X$sp$X1268.800049
dat$energy<-X$energy$X389.54
dat$enter<-X$enterprise$X456.8
dat$finance<-X$finance$X433.48
dat$health<-X$health$X372.26
dat$indus<-X$industrial$X292.73
dat$info<-X$informational$X337.52
dat$pharma<-X$pharmaceutical$X302.76
dat$tele<-X$tellecommunication$X117.98
dat$yield<-X$us10year$X4.3911

abc<-cbind(X$eurusd,X$ftse$X5681.5,X$nasdaq$X1679.93,X$energy$X389.54,X$enterprise$X456.8,
           X$finance$X433.48,X$health$X372.26,X$industrial$X292.73,X$informational$X337.52,X$pharmaceutical$X302.76,
           X$tellecommunication$X117.98,X$us10year$X4.3911)

abc<-abc[1:2608,]
scaled.abc <- scale(abc, center=TRUE)

scaled.abc<-cbind(scaled.abc,oil$oil)
abc<-data.frame(abc)
colnames(scaled.abc)<-c("eurusd","ftse","nasdaq","energy","enterprise","finance","health","industrial","info","pharma","telecom","us10yearbond","oil") 



#Macroeconmic factors
date <- read.csv("/Users/pinankshah/Downloads/bigdata/date.csv", header=TRUE, stringsAsFactors= FALSE)
y<-dat$sp
y<-data.frame(y)
y<-y[1:2608,]
y[2609]<-y[2608]
scaled.y <- scale(y, center=TRUE)
scaled.y<-data.frame(scaled.y)
colnames(scaled.y)<-"S&P"



#energy
CHK_energy <- read.csv("/Users/pinankshah/Downloads/bigdata/CHK_energy.csv", header=TRUE, stringsAsFactors= FALSE)
CHK_energy<-cbind(CHK_energy$PX_LAST,macrodata)

CVX_energy <- read.csv("/Users/pinankshah/Downloads/bigdata/CVX_energy.csv", header=TRUE, stringsAsFactors= FALSE)
CVX_energy<-cbind(CVX_energy$PX_LAST,macrodata)

MUR_energy<- read.csv("/Users/pinankshah/Downloads/bigdata/MUR_energy.csv", header=TRUE, stringsAsFactors= FALSE)
MUR_energy<-cbind(MUR_energy$PX_LAST,macrodata)


#HES_energy<- read.csv("/Users/pinankshah/Downloads/bigdata/HES_energy.csv", header=TRUE, stringsAsFactors= FALSE)
#XON_energy<- read.csv("/Users/pinankshah/Downloads/bigdata/XON_energy.csv", header=TRUE, stringsAsFactors= FALSE)

#semiconductor

MU_semi <- read.csv("/Users/pinankshah/Downloads/bigdata/MU_semiconductor.csv", header=TRUE, stringsAsFactors= FALSE)
MU_semi<-cbind(MU_semi$PX_LAST,macrodata)

INTC_semi <- read.csv("/Users/pinankshah/Downloads/bigdata/INTC_semiconductor.csv", header=TRUE, stringsAsFactors= FALSE)
INTC_semi<-cbind(INTC_semi$PX_LAST,macrodata)

QCOM_semi <- read.csv("/Users/pinankshah/Downloads/bigdata/QCOM_semiconductor.csv", header=TRUE, stringsAsFactors= FALSE)
QCOM_semi<-cbind(QCOM_semi$PX_LAST,macrodata)

TXN_semi <- read.csv("/Users/pinankshah/Downloads/bigdata/TXN_semiconductor.csv", header=TRUE, stringsAsFactors= FALSE)
TXN_semi<-cbind(TXN_semi$PX_LAST,macrodata)

NVDA_semi <- read.csv("/Users/pinankshah/Downloads/bigdata/NVDA_semiconductor.csv", header=TRUE, stringsAsFactors= FALSE)
NVDA_semi<-cbind(NVDA_semi$PX_LAST,macrodata)


#banks
MS_bank <- read.csv("/Users/pinankshah/Downloads/bigdata/MS_bank.csv", header=TRUE, stringsAsFactors= FALSE)
MS_bank<-cbind(MS_bank$PX_LAST,macrodata)

JPM_bank <- read.csv("/Users/pinankshah/Downloads/bigdata/JPM_bank.csv", header=TRUE, stringsAsFactors= FALSE)
JPM_bank<-cbind(JPM_bank$PX_LAST,macrodata)

GS_bank <- read.csv("/Users/pinankshah/Downloads/bigdata/GS_bank.csv", header=TRUE, stringsAsFactors= FALSE)
GS_bank<-cbind(GS_bank$PX_LAST,macrodata)

BAC_bank <- read.csv("/Users/pinankshah/Downloads/bigdata/BAC_bank.csv", header=TRUE, stringsAsFactors= FALSE)
BAC_bank<-cbind(BAC_bank$PX_LAST,macrodata)

C_bank <- read.csv("/Users/pinankshah/Downloads/bigdata/C_bank.csv", header=TRUE, stringsAsFactors= FALSE)
C_bank<-cbind(C_bank$PX_LAST,macrodata)


#pharma
PFE_pharma <- read.csv("/Users/pinankshah/Downloads/bigdata/PFE_PHARMA.csv", header=TRUE, stringsAsFactors= FALSE)
PFE_pharma<-cbind(PFE_pharma$PX_LAST,macrodata)

MRK_pharma <- read.csv("/Users/pinankshah/Downloads/bigdata/MRK_PHARMA..csv", header=TRUE, stringsAsFactors= FALSE)
MRK_pharma<-cbind(MRK_pharma$PX_LAST,macrodata)

AGN_pharma <- read.csv("/Users/pinankshah/Downloads/bigdata/AGN_PHARMA..csv", header=TRUE, stringsAsFactors= FALSE)
AGN_pharma<-cbind(AGN_pharma$PX_LAST,macrodata)

ENDP_pharma <- read.csv("/Users/pinankshah/Downloads/bigdata/ENDP_PHARMA..csv", header=TRUE, stringsAsFactors= FALSE)
ENDP_pharma<-cbind(ENDP_pharma$PX_LAST,macrodata)

PRGO_pharma <- read.csv("/Users/pinankshah/Downloads/bigdata/PRGO_PHARMA.csv", header=TRUE, stringsAsFactors= FALSE)
PRGO_pharma<-cbind(PRGO_pharma$PX_LAST,macrodata)

#tech
AAPL_tech <- read.csv("/Users/pinankshah/Downloads/bigdata/AAPL_TECH.csv", header=TRUE, stringsAsFactors= FALSE)
AAPL_tech<-cbind(AAPL_tech$PX_LAST,macrodata)

EBAY_tech <- read.csv("/Users/pinankshah/Downloads/bigdata/EBAY_TECH.csv", header=TRUE, stringsAsFactors= FALSE)
EBAY_tech<-cbind(EBAY_tech$PX_LAST,macrodata)

MSFT_tech <- read.csv("/Users/pinankshah/Downloads/bigdata/MSFT_TECH.csv", header=TRUE, stringsAsFactors= FALSE)
MSFT_tech<-cbind(MSFT_tech$PX_LAST,macrodata)

AMZN_tech <- read.csv("/Users/pinankshah/Downloads/bigdata/AMZN_TECH.csv", header=TRUE, stringsAsFactors= FALSE)
AMZN_tech<-cbind(AMZN_tech$PX_LAST,macrodata)

INTU_tech <- read.csv("/Users/pinankshah/Downloads/bigdata/INTU_TECH.csv", header=TRUE, stringsAsFactors= FALSE)
INTU_tech<-cbind(INTU_tech$PX_LAST,macrodata)

#Analysis for tech stocks
train<-1:1500
test<-1501:2517

#Linear Regression
train_AAPL_df<-data.frame(AAPL_tech[train,])
test_AAPL_df<-data.frame(AAPL_tech[test,])

train_AAPL_mat<-as.matrix(AAPL_tech[train,])
test_AAPL_mat<-as.matrix(AAPL_tech[test,])


linear1=lm(train_AAPL$AAPL_tech.PX_LAST~.,data=train_AAPL[,2:15])
summary(linear1)
predict1<-predict(linear1,test_AAPL[,2:15])
sqrt(mean((predict1-test_AAPL$AAPL_tech.PX_LAST)^2))

#LASSO
grid<-10^seq(10,-2,length=100)

lasso.mod<-glmnet(train_AAPL_mat[,2:15],train_AAPL_mat[,1:1],alpha=1,lambda=grid)
plot(lasso.mod)
cv.out<-cv.glmnet(train,ytrain,alpha=1)
plot(cv.out)
bestlam<-cv.out$lambda.min
lasso.pred<-predict(lasso.mod,s=bestlam,test)
sqrt(mean((lasso.pred-ytest)^2))

out<-glmnet(scaled.abc,y1,alpha=1,lambda=grid)
lasso.coeff=predict(out,type="coefficients",s=bestlam)[1:14,]
lasso.coeff
lasso.coeff[lasso.coeff!=0]




