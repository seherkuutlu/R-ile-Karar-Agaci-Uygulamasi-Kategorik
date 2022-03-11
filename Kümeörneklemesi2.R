library(datasets)

veri <- USArrests
veri

library(cluster)
library(factoextra)

str(veri)

summary(veri)

#verinin 4 değişkeni de numeric

#değişken isimlerini değiştirmek

names(veri)[1] <- 'Cinayet'
names(veri)[2] <- 'Saldiri'
names(veri)[3] <- 'Kentsel_yuzde'
names(veri)[4] <- 'Tecavuz'

veri

cinayet_veri <- table(veri$Cinayet)
barplot(cinayet_veri, main="Tutuklama", xlab="Cinayet Verisi" )

saldiri_veri <- table(veri$Cinayet)
barplot(saldiri_veri, main="Tutuklama", xlab="Saldiri Verisi")

tecavuz_veri <- table(veri$Tecavuz)
barplot(tecavuz_veri, main="tutuklama", xlab="Tecavuz verisi")

veri_norm <- scale(veri)
head(veri_norm)
head(veri)

heatmap(veri_norm, Colv = NA, Rowv = NA, scale = 'none')

#################
#k-means kümeleme
#################
set.seed(123)

km.res <- kmeans (veri_norm, 3 , nstart = 2)

fviz_cluster(km.res, veri , ellipse.type = "norm")

require("cluster")
sil <- silhouette(km.res$cluster , dist(veri_norm))
fviz_silhouette(sil)

pam.res <- pam(veri_norm, 3)
fviz_silhouette(pam.res)

########
#Hiyerarşik Kümeleme

hc.cut<- hcut( veri_norm ,  k  =  3 ,  hc_method  =  "complete" ) 
fviz_silhouette(hc.cut)

