# 4. faza: Analiza podatkov

library(mgcv)
library(forecast)

DODANAVREDNOST <- DODANAVRED[seq(1, 468, 36), "SLOVENIJA"]
PREBIVALSTVO <- prebivalstvo[(41:53),"Prebivalstvo"]
P <- data.frame(X=DODANAVREDNOST, Y=PREBIVALSTVO)
plot(DODANAVREDNOST ~ PREBIVALSTVO)
lm <- lm(X ~ Y, data = P)
summary(lm)
predict(lm)
plot(predict(lm))
lines(DODANAVREDNOST, PREBIVALSTVO, col="red", lwd=10)


#leta 2008 največji BDP,po letu 2008 kljub rasti prebivalstva BDP začne padati(gospodarska kriza)
attach(P)
pdf("slike/prebBDP.pdf")
plot(DODANAVREDNOST, PREBIVALSTVO, pch=20, col="blue")

mgam <- gam(Y ~ s(X), data = P)
curve(predict(mgam, data.frame(X=x)), add = TRUE, col = "red")


dev.off()
detach(P)


#napoved  BDP
pdf("slike/napovedBDP.pdf")
leto <- DODANAVRED[seq(1, 468, 36),"Leto"]
BL <- data.frame(X=leto,Y=DODANAVREDNOST)
bdpts <- ts(data=BL$Y, start=c(2000,1)) # časovni vektor
plot(forecast(bdpts), main="Napoved BDP", ylim=c(0,50000), ylab="Dodana vrednost", xlab="Leto")
dev.off()

#napoved prebivalstva
pdf("slike/napovedPREBIVALSTVA.pdf")
D <- data.frame(prebivalstvo)
prebts <- ts(data=D$Prebivalstvo, start=c(1960,1))
plot(forecast(prebts), main="Napoved prebivalstva", xlab="Leto", ylab="število prebivalcev")
dev.off()

dolg <- DOLG[(1:13), "Dolg"] #vrednost dolga


# stolpični graf-primerjava BDP z dolgom po letih
pdf("slike/dolg.pdf")

counts1 <- matrix(c(DODANAVREDNOST, dolg), nrow=2, byrow=TRUE)

barplot(counts1,xlab = "Leto", ylab="Vrednost", main= " Primerjava bruto dodane vrednosti in dolga po letih", 
        col=c("blue","green"), width=3, beside=TRUE,
        names.arg= 2000:2012)
legend("topleft", 
       legend = c("dodana vrednost", "dolg"), 
       fill = c("blue", "green"))




dev.off()


prebivalcireg <-PREBIVALSTVOREGIJE[,"Število.prebivalcev"]
DEJ <- as.integer(as.table(matrix(DODANAVRED[445, c(6:9, 11:18)])))

pdf("slike/delez.pdf")
range1 <- range(0, DEJ, prebivalcireg)
plot(DEJ, type="o", col="red",ylim=range1, axes=FALSE, ann=FALSE)
axis(1, at=1:12)
axis(2, at=0:36)
box()
lines(prebivalcireg, type="o", pch=22, col="blue", lty=2)
title(main="Primerjava deleža BDP in prebivalcev po regijah")
title(xlab="Regije")
title(ylab="delež")
legend("topright", c("delež dejavnosti","delež prebivalstva"), cex=0.8,
       col=c("red","blue"), lty=1:2)


dev.off()


