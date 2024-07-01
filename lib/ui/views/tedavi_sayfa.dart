import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/tedavi_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TedaviSayfa extends StatefulWidget {
  final TedaviModel gelenTedavi;

  TedaviSayfa(this.gelenTedavi);

  @override
  State<TedaviSayfa> createState() => _TedaviSayfaState();
}

class _TedaviSayfaState extends State<TedaviSayfa> {
  var refSes = FirebaseDatabase.instance.ref().child("uyariSes");
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void flexUyariVer(bool value) {
    refSes.set(value).then((_) {
      print("uyariSes güncellendi: $value");
    }).catchError((error) {
      print("Hata: $error");
    });
  }

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  Timer? _timer;
  int hareketSayac = 5; // Hareket sayaç
  bool tedaviTamamlandi = false;
  int aktifHareketSirasi = 0;
  int aktifSetSayisi = 0;
  int aktifTekrarSayisi = 0;
  int toplamHareketSayisi = 0;
  bool isCountingDown = false;
  ScaffoldMessengerState? _scaffoldMessenger;

  var bilgiMesaj = "Haydi başlayalım!";

  @override
  void initState() {
    super.initState();
    toplamHareketSayisi = widget.gelenTedavi.tedavi_hareket.length;
    context.read<TedaviSayfaCubit>().anlikFlexVeriAl();
    flexUyariVer(false);
    _audioPlayer = AudioPlayer();
  }

  void _uyariSesCal(bool durum) async {
    if (!durum) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.play(AssetSource('uyariSes.mp3'));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void baslaSayac() {
    setState(() {
      bilgiMesaj = "Süper, çok iyisiniz";
      _uyariSesCal(false); // hatalı ses kapat
      //flex uyari durdur
      flexUyariVer(false);

      isCountingDown = true;
      hareketSayac = 5;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (hareketSayac > 0) {
          hareketSayac--;
        } else {
          _timer?.cancel();
          aktifTekrarSayisi++;
          if (aktifTekrarSayisi >= int.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_tekrar)) {
            aktifTekrarSayisi = 0;
            aktifSetSayisi++;
            if (aktifSetSayisi >= int.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_set)) {
              aktifSetSayisi = 0;
              if (aktifHareketSirasi + 1 < toplamHareketSayisi) {
                aktifHareketSirasi++;
              } else {
                tedaviTamamlandi = true;
              }
            }
          }
          isCountingDown = false;
        }
      });
    });
  }

  void durdurSayac() {
    _uyariSesCal(true); // hatalı ses çal
    //flex uyari cal
    flexUyariVer(true);

    _timer?.cancel();
    setState(() {
      isCountingDown = false;
      bilgiMesaj = "Lütfen görseldeki doğru hareketi yapınız";
    });
  }

  Future<void> kontrolAci(int flexDegeri) async {
    int modelAci = int.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci);
    //yapilmasi gereken acidan 10 sapma degeri ekledik
    int altLimit = modelAci - 10;
    int ustLimit = modelAci + 10;

    if (flexDegeri >= altLimit && flexDegeri <= ustLimit && !isCountingDown) {
      _scaffoldMessenger?.hideCurrentSnackBar();
      baslaSayac();
    } else if ((flexDegeri < altLimit || flexDegeri > ustLimit) && isCountingDown) {
      durdurSayac();

      _scaffoldMessenger?.showSnackBar(
        SnackBar(
          content: Text('Hatalı hareket'),
          duration: Duration(days: 365), // Çok uzun bir süre veriyoruz, manuel kapatacağız
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.7;

    _scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Adımlar: ${aktifHareketSirasi + 1} / $toplamHareketSayisi"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Uygulanan tedavi adı: ${widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_ad}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              BlocListener<TedaviSayfaCubit, int>(
                listener: (context, flexDegeri) {
                  kontrolAci(flexDegeri);
                },
                child: BlocBuilder<TedaviSayfaCubit, int>(
                  builder: (context, flexDegeri) {
                    return Center(
                      child: Column(
                        children: [
                          flexDegeri != 0 ? Center() : Text("BANDAJ BAĞLI DEĞİL!"),
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci) + 100,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci),
                                      color: Colors.red,
                                    ),
                                    GaugeRange(
                                      startValue: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci),
                                      endValue: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci) + 10,
                                      color: Colors.green,
                                    ),
                                    GaugeRange(
                                      startValue: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci) + 10,
                                      endValue: double.parse(widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci) + 200,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                  pointers: <GaugePointer>[
                                    NeedlePointer(
                                      value: flexDegeri.toDouble(),
                                    ),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '$flexDegeri',
                                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      angle: 90,
                                      positionFactor: 0.5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  "Bu hareket için açı değeri: ${widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_aci}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  bilgiMesaj,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Image.network(
                      widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_gorsel,
                      width: imageWidth,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Resim yüklendiğinde resmin kendisini gösterir.
                        } else {
                          // Resim yüklenirken CircularProgressIndicator gösterir.
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 5,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                startValue: 0,
                                endValue: 5,
                                color: Colors.lightBlueAccent,
                              ),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: hareketSayac.toDouble(),
                              ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Container(
                                  child: Text(
                                    '$hareketSayac sn',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Kalan Set Sayısı: ${aktifSetSayisi} / ${widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_set}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Kalan Tekrar Sayısı: ${aktifTekrarSayisi} / ${widget.gelenTedavi.tedavi_hareket[aktifHareketSirasi].hareket_tekrar}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              if (tedaviTamamlandi)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //teadvi tamamla butonu
                        context.read<TedaviSayfaCubit>().tedaviTamamla(widget.gelenTedavi.tedavi_id);

                        analytics.logEvent(
                          name: 'biten_tedavi',
                          parameters: <String, dynamic>{
                            'tedavi_ad': widget.gelenTedavi.tedavi_ad,
                            'tedavi_aciklama': widget.gelenTedavi.tedavi_aciklama,
                            'tedavi_hareket_sayisi': widget.gelenTedavi.tedavi_hareketSayi,
                          },
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Tedavi başarıyla tamamlandı!",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  AnaSayfa()),
                        );
                      },
                      child: Text(
                        "Tedaviyi Tamamla",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
