import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/hareket_model.dart';

class TedaviModel{

  String tedavi_id;
  String tedavi_ad;
  String tedavi_aciklama;
  String tedavi_hareketIDS;
  String tedavi_tarih;
  String tedavi_mesaj;
  bool tedavi_durum;
  int tedavi_hareketSayi;
  List<HareketModel> tedavi_hareket;

  TedaviModel(
      {required this.tedavi_id,
        required this.tedavi_ad,
        required this.tedavi_aciklama,
        required this.tedavi_hareketIDS,
        required this.tedavi_tarih,
        required this.tedavi_mesaj,
        required this.tedavi_durum,
        required this.tedavi_hareketSayi,
        required this.tedavi_hareket});

  factory TedaviModel.fromJson(Map<String,dynamic> json){

    var hareketList = json['tedavi_hareket'] as List;
    List<HareketModel> hareketler = hareketList.map((i) => HareketModel.fromJson(i)).toList();
    
    return TedaviModel(
        tedavi_id: json["tedavi_id"] as String,
        tedavi_ad: json["tedavi_ad"] as String,
        tedavi_aciklama: json["tedavi_aciklama"] as String,
        tedavi_hareketIDS: json["tedavi_hareketIDS"] as String,
        tedavi_tarih: json["tedavi_tarih"] as String,
        tedavi_mesaj: json["tedavi_mesaj"] as String,
        tedavi_durum: json["tedavi_durum"] as bool,
        tedavi_hareketSayi: json["tedavi_hareketSayi"] as int,
        tedavi_hareket: hareketler  );

  }
}