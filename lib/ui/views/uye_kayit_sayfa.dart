import 'package:bitirme_projesi_fizik_tedavi/data/entity/durum_model.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/uye_kayit_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/uye_giris_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UyeKayitSayfa extends StatefulWidget {
  const UyeKayitSayfa({super.key});

  @override
  State<UyeKayitSayfa> createState() => _UyeKayitSayfaState();
}

class _UyeKayitSayfaState extends State<UyeKayitSayfa> {
  var tfMail = TextEditingController();
  var tfParola = TextEditingController();
  var tfAdSoyad = TextEditingController();
  var tfTelefon = TextEditingController();
  var tfDogumYil = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Üyelik Sayfası"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_add, color: Colors.teal, size: 100),
                SizedBox(height: 20),
                TextField(
                  controller: tfAdSoyad,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.teal),
                    labelText: "Ad Soyad Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: tfTelefon,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone, color: Colors.teal),
                    labelText: "Telefon Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: tfDogumYil,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range, color: Colors.teal),
                    labelText: "Doğum Yılınızı Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: tfMail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.teal),
                    labelText: "Mail Giriniz",
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
                    labelText: "Parola Giriniz",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    var cevap = await context.read<UyeKayitSayfaCubit>().kayitOl(
                      tfMail.text,
                      tfAdSoyad.text,
                      tfParola.text,
                      tfTelefon.text,
                      tfDogumYil.text,
                    );

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
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UyeGirisSayfa(),
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
                  child: Text("Kayıt Ol", style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UyeGirisSayfa(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Center(child: Text("Daha Önceden Bir Üyeliğim Var", style: TextStyle(fontSize: 18))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
