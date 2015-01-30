# 4. faza: Analiza podatkov


DODANAVREDNOST <- DODANAVRED[seq(1, 468, 36), "SLOVENIJA"]
P <- data.frame(X=CELOTNADODANAVREDNOST, Y=PREBIVALSTVO)
PREBIVALSTVO <- GIBANJEPREBIVALSTVA[(1: 13), "Prebivalstvo"]
vrednosti <- summary(X)
lm <- lm(X ~ Y, data = P)
summary(lm)
predict(lm)
plot(predict(lm))
lines(DODANAVREDNOST, PREBIVALSTVO, col="red", lwd=10)





pdf("slike/napov.pdf")
plot(DODANAVREDNOST ~ PREBIVALSTVO)

dev.off()

#leta 2008 največji BDP,po letu 2008 kljub rasti prebivalstva BDP začne padati(gospodarska kriza)

pdf("slike/preb-BDP.pdf")
plot(DODANAVREDNOST, PREBIVALSTVO, pch=20, col="blue")

mgam <- gam(Y ~ s(X), data = P)
curve(predict(mgam, data.frame(X=x)), add = TRUE, col = "red")


dev.off()



