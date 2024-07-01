import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/uye_giris_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/uye_kayit_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UyeGirisSayfa extends StatelessWidget {
  const UyeGirisSayfa({super.key});

  Future<bool> _checkUserExists() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool hastaBilgi = sp.getBool('hasta_bilgi') ?? false;
    if (hastaBilgi) {
      String? hastaMail = sp.getString('hasta_mail');
      String? hastaParola = sp.getString('hasta_parola');
      var cevap = await UyeGirisSayfaCubit().girisYap(hastaMail!, hastaParola!);
      return cevap.tf;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkUserExists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.data == true) {
          return AnaSayfa();
        } else {
          return UyeGirisSayfaForm();
        }
      },
    );
  }
}

class UyeGirisSayfaForm extends StatefulWidget {
  @override
  _UyeGirisSayfaFormState createState() => _UyeGirisSayfaFormState();
}

class _UyeGirisSayfaFormState extends State<UyeGirisSayfaForm> {
  var tfMail = TextEditingController();
  var tfParola = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Üye Giriş Sayfası"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, color: Colors.teal, size: 100),
                SizedBox(height: 20),
                TextField(
                  controller: tfMail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.teal),
                    labelText: "Mail Adresinizi Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: tfParola,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.teal),
                    labelText: "Parolanızı Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    var cevap = await context
                        .read<UyeGirisSayfaCubit>()
                        .girisYap(tfMail.text, tfParola.text);
                    if (cevap.tf) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${cevap.text}",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      );

                      var sp = await SharedPreferences.getInstance();
                      sp.setString("hastaID", cevap.id);
                      sp.setString("hasta_adsoyad", cevap.hasta_adsoyad);
                      sp.setString("hasta_mail", cevap.hasta_mail);
                      sp.setString("hasta_tel", cevap.hasta_tel);
                      sp.setString("hasta_resim", cevap.hasta_resim);
                      sp.setString("hasta_parola", tfParola.text);
                      sp.setBool("hasta_bilgi", true);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnaSayfa(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${cevap.text}",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Giriş Yap", style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UyeKayitSayfa(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Bir Üyeliğim Yok", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
