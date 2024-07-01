import 'package:bitirme_projesi_fizik_tedavi/data/entity/eklem_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/repo/eklem_islemleri_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EklemlerSayfaCubit extends Cubit<List<EklemModel>>{
  EklemlerSayfaCubit():super(<EklemModel>[]);

  var erepo = EklemIslemleriRepository();

  Future<void> eklemYukle() async{
      var liste = await erepo.eklemYukle();
      var listeSon = liste.eklemler;
      emit(listeSon);
  }


}