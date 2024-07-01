import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';

class TedavilerModel{

  List<TedaviModel> tedaviModel;

  TedavilerModel({required this.tedaviModel});
  

  factory TedavilerModel.fromJson(List<dynamic> json) {
    List<TedaviModel> tedaviler = json.map((i) => TedaviModel.fromJson(i)).toList();
    return TedavilerModel(tedaviModel: tedaviler);
  }
}