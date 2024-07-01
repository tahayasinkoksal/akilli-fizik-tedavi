import 'package:bitirme_projesi_fizik_tedavi/data/entity/eklem_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/hareket_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedavi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/entity/tedavi/tedaviler_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/repo/tedavi_islemleri_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AktifTedavilerSayfaCubit extends Cubit<List<TedaviModel>>{
    AktifTedavilerSayfaCubit():super(<TedaviModel>[]);

    var erepo = TedaviIslemleriRepository();

    Future<void> tedaviYukle() async{
      var liste = await erepo.tedaviYukle();
      emit(liste.tedaviModel);

    }





}