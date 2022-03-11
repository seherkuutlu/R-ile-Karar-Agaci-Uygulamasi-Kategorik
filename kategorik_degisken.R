library('RWeka')
library(C50) 
library(rpart) 
library(rpart.plot) 
library(caret) 
library("partykit")

install.packages("ISLR")
library(ISLR)


veri <- Carseats
## 400 farklý maðazada çocuk oto koltuklarýnýn satýþý

str(veri)


colnames(veri) <- c("birim_satis","ucretlendirilen_fiyat","gelir_duzeyi","reklam_butcesi","nufus_buyuklugu",
                    "koltuk_fiyat", "kalite", "yas_ortalamasi","egitim_duzeyi", "kentsel_kirsal","abd_magaza")

## Maðazanýn ABD'de olup olmadýðýný gösteren bir faktör olan abd_magaza deðiþkeni ile çalýþacaðým
str(veri$abd_magaza)
## abd_magaza, factor veri tipindeki bir kategorik deðiþken

### C4.5 Algoritmasý
karar_c45 <- J48(abd_magaza ~., veri) 
show(karar_c45)
plot(karar_c45) 

### C5.0 Algoritmasý
karar_c50 <- C5.0(abd_magaza ~., data = veri)
plot(karar_c50)

### CART Algoritmasý
karar_cart <- rpart(abd_magaza ~. , data = veri, method = "class" )
rpart.plot(karar_cart)


#### Algoritmalarýn Tahminlerini Elde Etme
yeni_veri <- veri

yeni_veri$c4_5 <- predict(karar_c45, data=veri, type = "class")
yeni_veri$c5_0 <- predict(karar_c50, newdata = veri, type = "class")
yeni_veri$cart <- predict(karar_cart, data= veri , type = "class")

## Gerçek deðerler ile tahminleri karþýlaþtýrma
# C4.5 karþýlaþtýrýlmasý
confusionMatrix(yeni_veri$c4_5, veri$abd_magaza)

# C5_0 karsilastirmasi
confusionMatrix(yeni_veri$c5_0, veri$abd_magaza)
# CART karsilastirmasi
confusionMatrix(yeni_veri$cart, veri$abd_magaza)



######### veriyi egitim ve test olarak ayirma #########
set.seed(123)
orneklem<- sample(1:NROW(veri), NROW(veri)*0.8)
train <- veri[orneklem, ]  
test <- veri[-orneklem, ]


dim(veri)
dim(train)
dim(test)


#Algoritmalarýn eðitim verisi ile eðitilmesi
eg_karar_c45 <- J48(abd_magaza ~., data = train)
eg_karar_c50 <- C5.0(abd_magaza ~., data = train)
eg_karar_cart <- rpart(abd_magaza ~., data = train, method = "class")

test_sonuclari <- test

#Eðitilen modellerin test verisi tahmini
test_sonuclari$c4_5 <- predict(eg_karar_c45,newdata = test_sonuclari, type = "class")
test_sonuclari$c5_0 <- predict(eg_karar_c50, newdata = test_sonuclari, type = "class")
test_sonuclari$cart <- predict(eg_karar_cart, newdata = test_sonuclari, type = "class")

#C4.5 karþýlaþtýrýlmasý
confusionMatrix(test_sonuclari$c4_5, test_sonuclari$abd_magaza)
# C5_0 karsilastirmasi
confusionMatrix(test_sonuclari$c5_0, test_sonuclari$abd_magaza)
# CART karsilastirmasi
confusionMatrix(test_sonuclari$cart, test_sonuclari$abd_magaza)
 
table(test_sonuclari$c4_5, test_sonuclari$abd_magaza)
table(test_sonuclari$c5_0, test_sonuclari$abd_magaza)
table(test_sonuclari$cart, test_sonuclari$abd_magaza)


