# Uvoz s spletne strani
# 
# library(XML)
# 
# # Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# # iz vozlišč, ki ustrezajo podani poti.
# stripByPath <- function(x, path) {
#   unlist(xpathApply(x, path,
#                     function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
# }
# 
# uvozi.obcine <- function() {
#   url.obcine <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
#   doc.obcine <- htmlTreeParse(url.obcine, useInternalNodes=TRUE)
#   
#   # Poiščemo vse tabele v dokumentu
#   tabele <- getNodeSet(doc.obcine, "//table")
#   
#   # Iz druge tabele dobimo seznam vrstic (<tr>) neposredno pod
#   # trenutnim vozliščem
#   vrstice <- getNodeSet(tabele[[2]], "./tr")
#   
#   # Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
#   # s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
#   seznam <- lapply(vrstice[2:length(vrstice)], stripByPath, "./td")
#   
#   # Iz seznama vrstic naredimo matriko
#   matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
#   
#   # Imena stolpcev matrike dobimo iz celic (<th>) glave (prve vrstice) prve tabele
#   colnames(matrika) <- gsub("\n", " ", stripByPath(tabele[[2]][[1]], ".//th"))
#   
#   # Podatke iz matrike spravimo v razpredelnico
#   return(data.frame(apply(gsub("\\*", "",
#                           gsub(",", ".",
#                           gsub("\\.", "", matrika[,2:5]))),
#                     2, as.numeric), row.names=matrika[,1]))
# }
# 
# 

library(XML)

# Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1", xmlValue(y))))
}

uvozi.dejavnosti <- function() {
  url.dejavnosti <- "http://www.stat.si/novica_prikazi.aspx?id=6254"
  doc.dejavnosti <- htmlTreeParse(url.dejavnosti, useInternalNodes=TRUE)
  

tabele <- getNodeSet(doc.dejavnosti, "//table[@rules]")
  
 
  
vrstice <- getNodeSet(tabele[[1]], "./tr")
  
 
    
seznam <- lapply(vrstice[3:length(vrstice)], stripByPath, "./td")
  
 
    
matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)

colnames(matrika) <- gsub("\n", " ", stripByPath(vrstice[[1]], ".//td"))
  
  
    
dejavnostidata=data.frame(apply(gsub("\\.", "", matrika[,2:3]),
                       2, as.numeric), row.names=matrika[,1])

return(dejavnostidata)    
}










