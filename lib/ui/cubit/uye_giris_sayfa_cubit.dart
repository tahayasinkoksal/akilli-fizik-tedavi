import 'package:bitirme_projesi_fizik_tedavi/data/entity/kisi_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/repo/uye_islemleri_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UyeGirisSayfaCubit extends Cubit<KisiModel>{
  UyeGirisSayfaCubit():super(KisiModel(id: "", hasta_adsoyad: "", hasta_mail: "", hasta_tel: "", hasta_resim: "", tf: true, text: ""));

  var uyerepo = UyeIslemleriRepository();

  Future<KisiModel> girisYap(String hasta_mail,String hasta_parola) async{
    var gelenKisiModel = uyerepo.girisYap(hasta_mail, hasta_parola);
    return gelenKisiModel;

  }

}