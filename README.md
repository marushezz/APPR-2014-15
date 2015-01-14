# Analiza podatkov s programom R, 2014/15

Avtor: Maruša Valant

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Tema projekta je analiza regionalne bruto dodane vrednosti v osnovnih cenah po letu,standardni klasifikaciji dejavnosti in regijah. Projekt bo v tabeli vseboval posamezne regije(imenska spremenljivka),dejavnosti(imenska spremenljivka),strukturo po regijah in strukturo po dejavnostih (urejenostni spremenljivki) in dodane vrednosti po regijah in dejavnostih(številski spremenljivki).

Moj cilj je ugotoviti katera dejavnost v posamezni regiji prinaša največjo dodano vrednost in v kateri regiji je posamezna dejavnost v ospredju.

Podatke za projekt sem dobila na spletni strani Statističnega urada Republike Slovenije (http://pxweb.stat.si/pxweb/Dialog/varval.asp?ma=0309202S&ti=Regionalna+bruto+dodana+vrednost+po+dejavnostih+v+osnovnih+cenah%2C+teko%E8e+cene%2C+Slovenija%2C+letno&path=../Database/Ekonomsko/03_nacionalni_racuni/30_03092_regionalni_rac/&lang=2
in http://www.stat.si/novica_prikazi.aspx?id=6254 ).
## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
