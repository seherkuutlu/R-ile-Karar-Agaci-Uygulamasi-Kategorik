Karar ağacı metodu, regresyon gibi sınıflandırmaya dayalı bir metoddur. 
Özellikle parametrik olmayan veri setlerinde tercih edilmektedir.
Ayrıca görselleştirilebilirliği sayesinde yorumu ve kullanımı oldukça popüler bir metoddur. 
Karar ağacı algoritmaları kullanılırken dikkat edilmelidir. Çünkü her algoritma her veri tipine uygun değildir.

* C4.5 ve C5.0 algoritmaları sürekli veri tiplerini tahmin edemez. Kategorik değişkenler için uygundur.
* CART algoritması ise hem kategorik hem de sürekli veri tipleri için uygundur. Ancak algoritma kullanırken method kısmını doğru kodlamaya dikkat edilmelidir.
*  method="class" kategorik, method="anova" sürekli 

Bu algoritmaların dışında scikit learn kütüphanesi içerisinden hem kategorik hem de sürekli değişkenlerin tahminini yapacak paketler bulunabilir. 
(Ancak kategorik değişkenler encode edilmelidir)
