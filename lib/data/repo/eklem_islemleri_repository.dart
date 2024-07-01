import 'dart:convert';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/eklem_model.dart';
import 'package:dio/dio.dart';

class EklemIslemleriRepository {

  Future<EklemCevap> eklemYukle() async {
    var url = "https://tedavi.tahayasinkoksal.com.tr/api/eklemler.php";
    var gidecekVeriler = {"apiKey": "111"};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));
    //print("Gelen eklem json: ${cevap}");

    var cevapJson = jsonDecode(cevap.data);

    // EklemCevap nesnesi olarak dönüştürülmeli
    var eklemModelCevap = EklemCevap.fromJson(cevapJson);

    return eklemModelCevap;
  }



}