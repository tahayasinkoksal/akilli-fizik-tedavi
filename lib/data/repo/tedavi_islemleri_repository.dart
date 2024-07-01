import 'dart:async';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedaviler_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TedaviIslemleriRepository{

  var kayitliHastaID = "";

  //kayitli user bilgilerini almak
  Future<void> userKontrol () async {
    var sp = await SharedPreferences.getInstance();
    var hasta_bilgi = sp.getBool("hasta_bilgi") ?? false;

    print("Hasta kayit durumu: $hasta_bilgi");

    if(hasta_bilgi){
      //hasta var demek ana sayfaya gidelim.
      var hastaID = sp.getString("hastaID") ?? "yok";
      kayitliHastaID = hastaID;

    }
  }

  //aktif tedavileri getirir
  Future<TedavilerModel> tedaviYukle() async{
    await userKontrol();

    var url = "https://tedavi.tahayasinkoksal.com.tr/api/tedaviler.php";
    var gidecekVeriler = {"apiKey": "111", "hasta_id": kayitliHastaID};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));
    //print("Gelen eklem json: ${cevap}");

    var cevapJson = jsonDecode(cevap.data);

    var tedavilerModelCevap = TedavilerModel.fromJson(cevapJson);
    //print("ILK VERI: ${tedavilerModelCevap.tedaviModel[0].tedavi_ad}");
    return tedavilerModelCevap;

  }

  //tedavi tamamlar
  Future<void> tedaviTamamla(String tedavi_id) async{
    await userKontrol();

    var url = "https://tedavi.tahayasinkoksal.com.tr/api/tedaviTamamla.php";
    var gidecekVeriler = {"tedavi_id": tedavi_id, "hasta_id": kayitliHastaID};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));
    print("Gelen tedavi bitis json: ${cevap}");

    var cevapJson = jsonDecode(cevap.data);


  }

  //biten tedavileri getirir
  Future<TedavilerModel> tedaviYukleBiten() async{
    await userKontrol();

    var url = "https://tedavi.tahayasinkoksal.com.tr/api/tamamlanan_tedaviler.php";
    var gidecekVeriler = {"apiKey": "111", "hasta_id": kayitliHastaID};

    var cevap = await Dio().post(url, data: FormData.fromMap(gidecekVeriler));
    //print("Gelen eklem json: ${cevap}");

    var cevapJson = jsonDecode(cevap.data);

    var tedavilerModelCevap = TedavilerModel.fromJson(cevapJson);
    //print("ILK VERI: ${tedavilerModelCevap.tedaviModel[0].tedavi_ad}");
    return tedavilerModelCevap;

  }

  //Firebase realtimeDB den veri alır
  Stream<int> anlikFlexVeriAl() {
    var refTest = FirebaseDatabase.instance.ref().child("flexVerisi");

    // Veri değişikliklerini dinlemek için StreamController kullanıyoruz
    StreamController<int> controller = StreamController<int>();

    // onValue ile veri değişikliklerini dinliyoruz
    refTest.onValue.listen((event) {
      var gelenDeger = event.snapshot.value;

      if (gelenDeger != null) {
        int flexDegeri = gelenDeger as int;

        controller.add(flexDegeri); // değeri StreamController'a ekliyoruz
      } else {
        controller.addError('Veri bulunamadı');
      }
    });

    return controller.stream;
  }






}