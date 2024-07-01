class HareketModel{

     String hareket_id;
     String hareket_ad;
     String hareket_aciklama;
     String hareket_gorsel;
     String hareket_eklemID;
     String hareket_eklemAd;
     String hareket_eklem_resim;
     String hareket_eklem_aciklama;
     String hareket_bandajDurum;
     String hareket_aciDurum;
     String hareket_aci;
     String hareket_set;
     String hareket_tekrar;

     HareketModel(
      {required this.hareket_id,
        required this.hareket_ad,
        required this.hareket_aciklama,
        required this.hareket_gorsel,
        required this.hareket_eklemID,
        required this.hareket_eklemAd,
        required this.hareket_eklem_resim,
        required this.hareket_eklem_aciklama,
        required this.hareket_bandajDurum,
        required this.hareket_aciDurum,
        required this.hareket_aci,
        required this.hareket_set,
        required this.hareket_tekrar});

     factory HareketModel.fromJson(Map<String,dynamic> json){

       return HareketModel(hareket_id: json["hareket_id"] as String,
           hareket_ad: json["hareket_ad"] as String,
           hareket_aciklama: json["hareket_aciklama"] as String,
           hareket_gorsel: json["hareket_gorsel"] as String,
           hareket_eklemID: json["hareket_eklemID"] as String,
           hareket_eklemAd: json["hareket_eklemAd"] as String,
           hareket_eklem_resim: json["hareket_eklem_resim"] as String,
           hareket_eklem_aciklama: json["hareket_eklem_aciklama"] as String,
           hareket_bandajDurum: json["hareket_bandajDurum"] as String,
           hareket_aciDurum: json["hareket_aciDurum"] as String,
           hareket_aci: json["hareket_aci"] as String,
           hareket_set: json["hareket_set"] as String,
           hareket_tekrar: json["hareket_tekrar"] as String);


     }
}