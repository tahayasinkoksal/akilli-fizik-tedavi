import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/aktif_tedaviler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/tedavi_detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AktifTedavilerSayfa extends StatefulWidget {
  const AktifTedavilerSayfa({super.key});

  @override
  State<AktifTedavilerSayfa> createState() => _AktifTedavilerSayfaState();
}

class _AktifTedavilerSayfaState extends State<AktifTedavilerSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AktifTedavilerSayfaCubit>().tedaviYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<AktifTedavilerSayfaCubit, List<TedaviModel>>(
        builder: (context, tedaviListesi) {
          if (tedaviListesi.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: tedaviListesi.length,
              itemBuilder: (context, indeks) {
                var tedavi = tedaviListesi[indeks];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TedaviDetaySayfa(tedaviModel: tedavi)),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.network(
                                tedavi.tedavi_hareket[0].hareket_eklem_resim,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
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
                            ),
                            if (tedavi.tedavi_durum)
                              Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Bandaj Gerekli",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Image.asset(
                                        'assets/bandaj.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tedavi.tedavi_ad,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TedaviDetaySayfa(tedaviModel: tedavi)),
                                  );
                                },
                                child: Text("Tedaviye Başla", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "Burada hiçbir şey yok :( \nTedaviler için doktorunuza danışınız.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
