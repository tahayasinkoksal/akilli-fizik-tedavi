import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa_bottom_nav/aktif_tedaviler_sayfa.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa_bottom_nav/biten_tedaviler_sayfa.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa_bottom_nav/eklemler_sayfa.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa_bottom_nav/kisi_detay_sayfa.dart';

class AnaSayfa extends StatefulWidget {
  AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  int secilenIndeks = 0;
  final sayfalar = [
    const AktifTedavilerSayfa(),
    const EklemlerSayfa(),
    const BitenTedavilerSayfa(),
    const KisiDetaySayfa()
  ];

  //firenase Analytics islemleri
  Future<void> firebaseRealtimeAnalytics(String ekranAD) async {
    await analytics.logEvent(
      name: 'ana_sayfa_ekranAD',
      parameters: <String, dynamic>{
        'ekran_ad': ekranAD.toString(),
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //ilk acilista ana ekran adi gonderildi
    analytics.logEvent(
      name: 'ana_sayfa_ekranAD',
      parameters: <String, dynamic>{
        'ekran_ad': "Aktif Tedaviler",
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akıllı Fizik Tedavi"),
        backgroundColor: Colors.teal,
      ),
      body: sayfalar[secilenIndeks],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Aktif Tedaviler"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Eklemler"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Biten Tedaviler"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Kişi Detay"),
        ],
        currentIndex: secilenIndeks,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.teal, // Eklenmiş: Seçili olmayan öğelerin rengi
        backgroundColor: Colors.white, // Eklenmiş: Alt menünün arka plan rengi
        onTap: (indeks) {
          setState(() {
            //sayfa isimlerini firebase realtime database kaydetme
            List sayfalar = ["Aktif Tedaviler","Eklemler","Biten Tedaviler","Kişi Detay"];
            firebaseRealtimeAnalytics(sayfalar[indeks]);

            secilenIndeks = indeks;
          });
        },
      ),
    );
  }
}
