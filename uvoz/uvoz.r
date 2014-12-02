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
  return(read.table("podatki/BRUTOSLO.csv", sep = ";", as.is = TRUE,
<<<<<<< HEAD
                     
                
                      fileEncoding = "Windows-1250"))
}

#Zapišimo podatke v razpredelnico druzine.
cat("Uvažam podatke o BRUTOSLO...\n")
BRUTOSLO <- uvoziSLO()
=======
                    
                    
                    col.names = c("Leto", "", "Dejavnosti", "SLOVENIJA", "Zahodna Slovenija", "Obalno-kraška", "Goriška", "Gorenjska", "Osrednjeslovenska",  "Vzhodna Slovenija", "Notranjsko-kraška", "Jugovzhodna Slovenija", "Spodnjeposavska", "Zasavska",	"Savinjska", "Koroška", "Podravska",	"Pomurska"
                    ),                  
                    
                    
                    fileEncoding = "Windows-1250"))
}


#Zapišimo podatke v razpredelnico druzine.
cat("Uvažam podatke o BRUTOSLO...\n")
BRUTOSLO <- uvoziSLO()


pdf("slike/graf.pdf")


slices <- c(2.7, 25.2, 20.8, 5.9, 20.4, 4.3, 4.5, 7.5, 9.1, 17.8, 2.7)
lbls <- c("A Kmetijstvo, gozdarstvo in ribištvo",
          "BCDE Predelovalne dejavnosti", "rudarstvo in druga industrija", "Predelovalne dejavnosti",
          "F Gradbeništvo", "GHI Trgovina", "gostinstvo", "promet", "J Informacijske in komunikacijske dejavnosti",
          "K Finančne in zavarovalniške dejavnosti", "L Poslovanje z nepremičninami",
          "MN Strokovne, znanstvene, tehnične in druge posl. dejavnosti",
          "OPQ Uprava in obramba, obv. soc. varnost, izob., zdravstvo",
          "RSTU Druge dejavnosti")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Struktura po dejavnostih v Sloveniji leta 2012")


dev.off()





>>>>>>> d18df223d755a8210a8129a1ef8563e542d647f3
