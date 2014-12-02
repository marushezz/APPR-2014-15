# 2. faza: Uvoz podatkov

# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvoziDruzine <- function() {
#   return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
#                       row.names = 1,
#                       col.names = c("obcina", "en", "dva", "tri", "stiri"),
#                       fileEncoding = "Windows-1250"))
# }
# 
# # Zapišimo podatke v razpredelnico druzine.
# cat("Uvažam podatke o družinah...\n")
# druzine <- uvoziDruzine()
# 
# # Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# # potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# # datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# # 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# # fazah.

#Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvoziSLO <- function() {
  return(read.table("podatki/brutoslo.csv", sep = ";", as.is = TRUE,
                    
                    
                    col.names = c("Leto", "", "Dejavnosti", "SLOVENIJA", "Zahodna Slovenija", "Obalno-kraška", "Goriška", "Gorenjska", "Osrednjeslovenska",  "Vzhodna Slovenija", "Notranjsko-kraška", "Jugovzhodna Slovenija", "Spodnjeposavska", "Zasavska",	"Savinjska", "Koroška", "Podravska",	"Pomurska"
                    ),                  
                    
                  
                    fileEncoding = "Windows-1250"))
}


#Zapišimo podatke v razpredelnico druzine.
cat("Uvažam podatke o brutoslo...\n")
BRUTOSLO <- uvoziSLO()


#tortni graf

pdf("slike/graf.pdf", paper="a4r")
slices <- BRUTOSLO[(458:468), "SLOVENIJA"]
lbls <- BRUTOSLO[(458:468), "Dejavnosti"]
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) 
lbls <- paste(lbls,"%",sep="") # dodajanje % 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Struktura po dejavnostih v Sloveniji leta 2012")

dev.off()


#tabela xml
source("lib/xml.r")
dodanavrednost <- uvozi.dejavnosti()
cat("Uvažam podatke bruto dodane vrednosti za Slovenijo leta 2012 in 2013")
 
#stolpični graf
dod <- dodanavrednost[(2:20), "X2012"]
dodan <- dodanavrednost[(2:20), "X2013"]
counts <- table(dod,dodan)
barplot(counts, xlab="leto", ylab="dodana vrednost", main="Primerjava bruto dodane vrednosti v Sloveniji", col=c("blue","red"),
        width=2, beside=TRUE, legend = dodanavrednost[(2:20), "row.names"])


