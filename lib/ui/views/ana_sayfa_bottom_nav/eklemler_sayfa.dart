import 'package:bitirme_projesi_fizik_tedavi/data/entity/eklem_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/eklemler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa_bottom_nav/eklem_detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EklemlerSayfa extends StatefulWidget {
  const EklemlerSayfa({super.key});

  @override
  State<EklemlerSayfa> createState() => _EklemlerSayfaState();
}

class _EklemlerSayfaState extends State<EklemlerSayfa> {
  @override
  void initState() {
    super.initState();
    context.read<EklemlerSayfaCubit>().eklemYukle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EklemlerSayfaCubit, List<EklemModel>>(
      builder: (context, eklemListesi) {
        if (eklemListesi.isNotEmpty) {
          return GridView.builder(
            itemCount: eklemListesi.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.1,
            ),
            itemBuilder: (context, indeks) {
              var eklem = eklemListesi[indeks];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EklemDetaySayfa(eklem: eklem),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                            image: DecorationImage(
                              image: NetworkImage(eklem.eklem_resim),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(), // Resim yüklenirken göstereceğimiz progress indicator.
                              ),
                              Image.network(
                                eklem.eklem_resim,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Resim yüklendiğinde child yani resim gösterilir.
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
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              eklem.eklem_ad,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EklemDetaySayfa(eklem: eklem),
                                  ),
                                );
                              },
                              child: Text("Detay",style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
