class EklemModel{
  String eklem_id;
  String eklem_ad;
  String eklem_resim;
  String eklem_aciklama;
  String mesaj;

  EklemModel(
      {required this.eklem_id,
        required this.eklem_ad,
        required this.eklem_resim,
        required this.eklem_aciklama,
        required this.mesaj});

  factory EklemModel.fromJson(Map<String,dynamic> json){
    return EklemModel(
        eklem_id: json["eklem_id"] as String,
        eklem_ad: json["eklem_ad"] as String,
        eklem_resim: json["eklem_resim"] as String,
        eklem_aciklama: json["eklem_aciklama"] as String,
        mesaj: json["mesaj"] as String);
  }
}

class EklemCevap{
  List<EklemModel> eklemler;

  EklemCevap({required this.eklemler});

  factory EklemCevap.fromJson(List<dynamic> json) {
    var eklemler = json.map((jsonArrayNesnesi) => EklemModel.fromJson(jsonArrayNesnesi)).toList();

    return EklemCevap(eklemler: eklemler);
  }


}