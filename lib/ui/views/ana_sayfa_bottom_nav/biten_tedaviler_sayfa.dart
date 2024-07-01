import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/aktif_tedaviler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/biten_tedaviler_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BitenTedavilerSayfa extends StatefulWidget {
  const BitenTedavilerSayfa({super.key});

  @override
  State<BitenTedavilerSayfa> createState() => _BitenTedavilerSayfaState();
}

class _BitenTedavilerSayfaState extends State<BitenTedavilerSayfa> {

  @override
  void initState() {
    super.initState();

    context.read<BitenTedavilerSayfaCubit>().tedaviYukleBiten();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BitenTedavilerSayfaCubit, List<TedaviModel>>(
      builder: (context,tedaviListesi){
        if(tedaviListesi.isNotEmpty){
          return GridView.builder(
            itemCount: tedaviListesi.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 1/1.1),
            itemBuilder: (context,indeks){
              var tedavi = tedaviListesi[indeks];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(tedavi.tedavi_hareket[0].hareket_eklem_resim),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${tedavi.tedavi_ad}", style: TextStyle(fontSize: 15)),
                          Text("TAMAMLANDI!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            },
          );
        }else{
          //veri yoksa
          return const Center(child: Text("Burada hiçbir şey yok :("),);
        }
      },
    );
  }
}
