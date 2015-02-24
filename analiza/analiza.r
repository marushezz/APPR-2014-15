# 4. faza: Analiza podatkov

library(mgcv)
library(forecast)

DODANAVREDNOST <- DODANAVRED[seq(1, 468, 36), "SLOVENIJA"]
PREBIVALSTVO <- prebivalstvo[(41:53),"Prebivalstvo"]
P <- data.frame(X=DODANAVREDNOST, Y=PREBIVALSTVO)
# plot(DODANAVREDNOST ~ PREBIVALSTVO)
# lm <- lm(X ~ Y, data = P)
# summary(lm)
# predict(lm)
# plot(predict(lm))
# lines(DODANAVREDNOST, PREBIVALSTVO, col="red", lwd=10)


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


#Stolpični graf primerjava deleža prebivalstva in deleža BDP
prebivalcireg <-PREBIVALSTVOREGIJE[,"Število.prebivalcev"] 
DEJ <- as.integer(as.table(matrix(DODANAVRED[445, c(6:9, 11:18)])))
# DEJ1 <- DEJ[order(DEJ)]
# prebivalcireg1 <- prebivalcireg[c(5 ,8, 10,  7, 12,  1,  2,  6,  3,  9, 11,  4)]
o <- order(DEJ)
DEJ1 <- DEJ[o]
prebivalcireg1 <- prebivalcireg[o]
  
pdf("slike/delez2.pdf")
prebdej <- matrix(c(prebivalcireg1, DEJ1), nrow=2, byrow=TRUE)
barplot(prebdej, sub= "Regije", ylab="Vrednost",
        main= "Primerjava deleža BDP in prebivalcev po regijah", 
        col=c("blue", " green"), width=3, beside=TRUE,
        names.arg=PREBIVALSTVOREGIJE[o,"Regije"], las = 2, cex.names = 0.4)
legend("topleft", legend = c("delež prebivalstva", "delež BDP"), 
       fill = c("blue", "green"))
dev.off()



#graf povezave BDP in dolga po letih
dolg <- DOLG[(1:13), "Dolg"] #vrednost dolga

pdf("slike/dolg2.pdf")

range1 <- range(0, dolg, DODANAVREDNOST)
plot(DODANAVREDNOST, type="o", col="red",ylim=range1, axes=FALSE, ann=FALSE)
axis(1, at=1:13, lab=c("2000" ,"2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010",
                       "2011", "2012"))
axis(2, at=10000*0:range1[2])
box()
lines(dolg, type="o", pch=22, col="blue", lty=2)
title(main="Primerjava vrednosti BDP in dolga po letih")
title(xlab="Leta")
title(ylab="vrednost")
legend("topleft", c("Vrednost BDP","vrednost dolga"), cex=0.8,
       col=c("red","blue"), lty=1:2)



dev.off()
