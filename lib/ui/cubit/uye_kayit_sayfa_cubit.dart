import 'package:bitirme_projesi_fizik_tedavi/data/entity/durum_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/data/repo/uye_islemleri_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UyeKayitSayfaCubit extends Cubit<DurumModel> {
  UyeKayitSayfaCubit():super(DurumModel(text: "Bir hata var gibi",tf: false));

  var uyerepo = UyeIslemleriRepository();

  Future<DurumModel> kayitOl(String hasta_mail, String hasta_adsoyad, String hasta_parola, String hasta_tel, String hasta_dogumyil) async{
      var durumCevap = await uyerepo.kayitOl(hasta_mail, hasta_adsoyad, hasta_parola, hasta_tel, hasta_dogumyil);
      return durumCevap;
  }

}