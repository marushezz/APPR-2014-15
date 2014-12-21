# 3. faza: Izdelava zemljevida

# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")

# Uvozimo zemljevid.
cat("Uvažam zemljevid...\n")
slo <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/SVN_adm.zip",
                       "slovenija", "SVN_adm1.shp", mapa = "zemljevid",
                       encoding = "Windows-1250")
# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.slo <- c()
  manjkajo <- ! nove.slo %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.slo[manjkajo]
  podatki <- rbind(podatki, M)
  ord <- rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)])
  out <- data.frame(podatki[order(rownames(podatki)), ])[ord, ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)[ord]
  }
  return(out)
}


# Narišimo zemljevid v PDF.
cat("Rišem zemljevid Slovenije...\n")
pdf("slike/Slovenija.pdf", width=6, height=4)

#Preuredimo podatke
povprecje <- preuredi(apply(DODANAVRED[445, c(6:9, 11:18)], 1, c), slo)


# Izračunamo povprečno velikost družine.
#dodanavrednost$X2013 <- apply(DODANAVRED["445", (5:18)], 1, function(x) (dodan/sum(dodan)*100)

min.povprecje <- min(povprecje, na.rm=TRUE)
max.povprecje <- max(povprecje, na.rm=TRUE)
norm.2012 <- (povprecje-min.povprecje)/(max.povprecje-min.povprecje)

n = 100
barve =rgb(1, 1, (n:1)/n)[unlist(1+(n-1)*norm.2012)]
plot(slo, col = barve,bg="lightgreen")
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
title("Povprečna bruto dodana vrednost leta 2012 po regijah")
LJUBLJANA <- slo$VARNAME_1 == "Ljubljana"
points(coordinates(slo), pch = ifelse(LJUBLJANA, 18, 0), cex = ifelse(LJUBLJANA, 0.5 ,0), col = ifelse(LJUBLJANA, "red", "white"))



dev.off()





