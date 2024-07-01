class KisiModel{
  String id;
  String hasta_adsoyad;
  String hasta_mail;
  String hasta_tel;
  String hasta_resim;
  bool tf;
  String text;

  KisiModel(
      {required this.id,
        required this.hasta_adsoyad,
        required this.hasta_mail,
        required this.hasta_tel,
        required this.hasta_resim,
        required this.tf,
        required this.text});

  factory KisiModel.fromJson(Map<String,dynamic> json){

    return KisiModel(
        id: json["id"] as String,
        hasta_adsoyad: json["hasta_adsoyad"] as String,
        hasta_mail: json["hasta_mail"] as String,
        hasta_tel: json["hasta_tel"] as String,
        hasta_resim: json["hasta_resim"] as String,
        tf: json["tf"] as bool,
        text: json["text"] as String);
  }
}

