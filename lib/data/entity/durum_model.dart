class DurumModel{
  String text;
  bool tf;

  DurumModel({required this.text, required this.tf});

  factory DurumModel.fromJson(Map<String,dynamic> json){

    return DurumModel(
        text: json["text"] as String,
        tf: json["tf"] as bool,);
  }
}