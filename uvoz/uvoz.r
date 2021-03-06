# 2. faza: Uvoz podatkov

# # Funkcija, ki uvozi podatke iz datoteke druzine.csv
# uvoziDruzine <- function() {
#   return(read.table("podatki/druzine.csv", sep = ";", as.is = TRUE,
#                       row.names = 1,
#             
#col.names = c("obcina", "en", "dva", "tri", "stiri"),
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
  return(read.table("podatki/DODANAVRED.csv", sep = ";", as.is = TRUE,
                    
                  
                    col.names = c("Leto", "", "Dejavnosti", "SLOVENIJA", "Zahodna Slovenija", "Obalno-kraška", "Goriška", "Gorenjska", "Osrednjeslovenska",  "Vzhodna Slovenija", "Notranjsko-kraška", "Jugovzhodna Slovenija", "Spodnjeposavska", "Zasavska",	"Savinjska", "Koroška", "Podravska",	"Pomurska"),                  
                    
                  
                    fileEncoding = "Windows-1250"))
}




#Zapišimo podatke v razpredelnico
cat("Uvažam podatke o DODANAVRED...\n")
DODANAVRED <- uvoziSLO()


 

#tortni graf

pdf("slike/graf.pdf")
slices <- DODANAVRED[(458:468), "SLOVENIJA"]
lbls <- gsub("[^A-Z]*([A-Z]+).*", "\\1", DODANAVRED[(458:468), "Dejavnosti"])
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) 
lbls <- paste(lbls,"%",sep="") # dodajanje % 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Struktura po dejavnostih v Sloveniji leta 2012")

dev.off()




#tabela xml
source("lib/xml.r")
dodanavrednost <- uvozi.dejavnosti()
cat("Podatki bruto dodane vrednosti za Slovenijo leta 2012 in 2013")
 
#stolpični graf
pdf("slike/plot.pdf")
dod <- dodanavrednost[(2:20), "X2012"]
dodan <- dodanavrednost[(2:20), "X2013"]
counts <- matrix(c(dod, dodan), nrow=2, byrow=TRUE)
barplot(counts, xlab="dejavnost", ylab="dodana vrednost", main="Primerjava bruto dodane vrednosti v Sloveniji", col=c("blue","red"),
        width=2, beside=TRUE, legend = 2012:2013, names.arg = substr(row.names(dodanavrednost)[2:20], 1, 1))
dev.off()



uvoziPREBIVALSTVO <- function() {
  return(read.table("podatki/prebivalstvo.csv", sep = ";", as.is = TRUE,
                    
                    
                    col.names = c("Leto", "Prebivalstvo"),                  
                    
                    
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o prebivalstvu ...\n")
prebivalstvo <- uvoziPREBIVALSTVO()





uvoziDRZAVNIDOLG <- function() {
  return(read.table("podatki/dolg.csv", sep = ";", as.is = TRUE,
                    
                    
                    col.names = c("Leto", "Dolg"),                  
                    
                    
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o državnemdolgu ...\n")
DOLG <- uvoziDRZAVNIDOLG()

uvoziPREB <- function() {
  return(read.table("podatki/prebreg1.csv", sep = ";", as.is = TRUE,
                    
                    
                    col.names = c("Regije", "Število prebivalcev"),                  
                    
                    
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o preb ...\n")
PREBIVALSTVOREGIJE <- uvoziPREB()