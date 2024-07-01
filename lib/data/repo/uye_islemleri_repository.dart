import 'dart:convert';

import 'package:bitirme_projesi_fizik_tedavi/data/entity/durum_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/kisi_model.dart';
import 'package:dio/dio.dart';

class UyeIslemleriRepository{

  Future<DurumModel> kayitOl(String hasta_mail, String hasta_adsoyad, String hasta_parola, String hasta_tel, String hasta_dogumyil) async{

    var url = "https://tedavi.tahayasinkoksal.com.tr/api/kayit.php";
    var gidecekVeriler = {"apiKey":"111","hasta_mail": hasta_mail,"hasta_adsoyad":hasta_adsoyad ,"hasta_parola" : hasta_parola, "hasta_tel":hasta_tel, "hasta_dogumyil":hasta_dogumyil};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));

    //print("CEVAP: ${cevap.data}");

    // Gelen cevabı önce JSON formatına dönüştür
    Map<String, dynamic> cevapJson = jsonDecode(cevap.data);

    // JSON'dan gerekli alanları alarak DurumModel oluştur
    var durumModelCevap = DurumModel.fromJson(cevapJson);
    return durumModelCevap;
  }

  Future<KisiModel> girisYap(String hasta_mail,String hasta_parola) async{

    var url = "https://tedavi.tahayasinkoksal.com.tr/api/giris.php";
    var gidecekVeriler = {"hasta_mail": hasta_mail, "hasta_parola" : hasta_parola};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));

    //print("CEVAP: ${cevap.data}");

    // Gelen cevabı önce JSON formatına dönüştür
    Map<String, dynamic> cevapJson = jsonDecode(cevap.data);

    // JSON'dan gerekli alanları alarak KisiModel oluştur
    var kisiModelCevap = KisiModel.fromJson(cevapJson);


    return kisiModelCevap;
  }


}