import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/repo/tedavi_islemleri_repository.dart';

class TedaviSayfaCubit extends Cubit<int> {
  TedaviSayfaCubit() : super(0); // Başlangıç değeri olarak 0 veriliyor

  var erepo = TedaviIslemleriRepository();

  void anlikFlexVeriAl() {
    erepo.anlikFlexVeriAl().listen((veri) {
      print("FLEX: $veri");
      emit(veri.toInt());
    }, onError: (error) {
      print("Hata: $error");
      emit(0); // Hata durumunda 0 emit ediliyor
    });
  }

  Future<void> tedaviTamamla(String tedavi_id) async{
    erepo.tedaviTamamla(tedavi_id);
  }

}
