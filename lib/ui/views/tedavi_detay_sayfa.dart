import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/tedavi_sayfa.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class TedaviDetaySayfa extends StatefulWidget {
  final TedaviModel tedaviModel;

  TedaviDetaySayfa({required this.tedaviModel});

  @override
  State<TedaviDetaySayfa> createState() => _TedaviDetaySayfaState();
}

class _TedaviDetaySayfaState extends State<TedaviDetaySayfa> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void _tedaviEkraniGit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  TedaviSayfa(widget.tedaviModel),
      ),
    );
  }

  Future<void> firebaseAnalyticsVeri(String tedavi_ad,String tedavi_aciklama, String tedavi_hareketSayi)async {
    await analytics.logEvent(
      name: 'baslatilan_tedavi',
      parameters: <String, dynamic>{
        'tedavi_ad': widget.tedaviModel.tedavi_ad.toString(),
        'tedavi_aciklama': widget.tedaviModel.tedavi_aciklama.toString(),
        'tedavi_hareket_sayisi': widget.tedaviModel.tedavi_hareketSayi.toString(),
      },
    );
  }

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bandajı Takınız"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Bandaj üzerindeki mavi çizgiyi hareketli eklemin ortasına getirerek cırtcırtları sıkıca yapıştırınız, "
                  "bu sayede tedaviniz daha doğru sonuçlar verecektir."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //Analytics veri gonderme
                  firebaseAnalyticsVeri(widget.tedaviModel.tedavi_ad.toString(), widget.tedaviModel.tedavi_aciklama.toString(),widget.tedaviModel.tedavi_hareketSayi.toString());

                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TedaviSayfa(widget.tedaviModel)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: Text(
                  "Taktım, tedaviye başlayabiliriz!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tedaviModel.tedavi_ad),
        backgroundColor: Colors.teal,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: isLargeScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    // Tedavi Hareket Resmi
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          widget.tedaviModel.tedavi_hareket[0].hareket_eklem_resim,
                          fit: BoxFit.cover,
                          width: isLargeScreen ? constraints.maxWidth * 0.5 : double.infinity,
                          height: 250,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Tedavi Bilgileri
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow("Tedavi Adı:", widget.tedaviModel.tedavi_ad),
                            SizedBox(height: 8),
                            _buildDetailRow("Tedavi Açıklama:", widget.tedaviModel.tedavi_aciklama),
                            SizedBox(height: 8),
                            _buildDetailRow("Tedavideki Hareket Sayısı:", widget.tedaviModel.tedavi_hareketSayi.toString()),
                            SizedBox(height: 8),
                            _buildDetailRow("Tedavi Tarihi Veriliş:", widget.tedaviModel.tedavi_tarih),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Tedaviye Başla Butonu
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: widget.tedaviModel.tedavi_durum ? _showWelcomeDialog : _tedaviEkraniGit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Tedaviye Başlayalım!",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
