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
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}


# Izračunamo povprečno velikost družine.
#dodanavrednost$X2013 <- apply(DODANAVRED["445", (5:18)], 1, function(x) (dodan/sum(dodan)*100)
min.povprecje <- min(DODANAVRED["445", (5:18)], na.rm=TRUE)
max.povprecje <- max(DODANAVRED["445", (5:18)], na.rm=TRUE)
povprecje <- DODANAVRED["445", (5:18)]
norm.2012 <- (DODANAVRED["445", (5:18)]-min.povprecje)/(max.povprecje-min.povprecje)
# Narišimo zemljevid v PDF.
cat("Rišem zemljevid...\n")
pdf("slike/zemljevid.pdf", width=6, height=4)

#n = 100
#barve =terrain.colors(n)[unlist(1+(n-1)*norm.2012)]
plot(slo, col = barve)
text(coordinates(slo),labels=as.character(slo$NAME_1),cex=0.3)
barve=rainbow(12)
 


dev.off()

