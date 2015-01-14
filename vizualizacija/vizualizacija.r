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
pdf("slike/Slovenija.pdf")

#Preuredimo podatke
povprecje <- preuredi(apply(DODANAVRED[445, c(6:9, 11:18)], 1, c), slo)

#spremenjene koordinate

koordinate <- coordinates(slo)
rownames(koordinate) <- as.character(slo$NAME_1)
koordinate["Obalno-kraška",1] <- koordinate["Obalno-kraška",1]-0.02#levo,desno
koordinate["Obalno-kraška",2] <- koordinate["Obalno-kraška",2]-0.085 #dol,gor
koordinate["Zasavska",2] <- koordinate["Zasavska",2]+0.01 
koordinate["Spodnjeposavska",1] <- koordinate["Spodnjeposavska",1]+0.08
koordinate["Spodnjeposavska",2] <- koordinate["Spodnjeposavska",2]


# Izračunamo povprečno vrednost
#dodanavrednost$X2013 <- apply(DODANAVRED["445", (5:18)], 1, function(x) (dodan/sum(dodan)*100)

min.povprecje <- min(povprecje, na.rm=TRUE)
max.povprecje <- max(povprecje, na.rm=TRUE)
norm.2012 <- (povprecje-min.povprecje)/(max.povprecje-min.povprecje)

n = 100
barve =rgb(1, 1, (n:1)/n)[unlist(1+(n-1)*norm.2012)]
plot(slo, col = barve,bg="lightgreen")
text(koordinate,labels=as.character(slo$NAME_1),cex=0.3)
title("Povprečna bruto dodana vrednost leta 2012 po regijah")
LJUBLJANA <- slo$VARNAME_1 == "Ljubljana"
#points(coordinates(slo), pch = ifelse(LJUBLJANA, 18, 0), cex = ifelse(LJUBLJANA, 0.5 ,0), col = ifelse(LJUBLJANA, "red", "white"))
points(14.51000, 46.06000, pch = 18, cex = 0.5, col = "red")

legend("bottomright", legend = round(seq(min.povprecje, max.povprecje, (max.povprecje-min.povprecje)/5)),
       fill = rgb(1, 1, (6:1)/6), bg = "white")
slo$dv2012 <- povprecje[c(1:12),]


dev.off()

pdf("slike/Slov.pdf")

print(spplot(slo, "dv2012" ,col.regions  = topo.colors(50),
             main = "Povprečna bruto dodana vrednost leta 2012 po regijah",
             sp.layout = list(list("sp.text", koordinate,slo$NAME_1, cex = 0.3))))



dev.off()





