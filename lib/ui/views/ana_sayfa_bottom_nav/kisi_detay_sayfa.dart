import 'package:bitirme_projesi_fizik_tedavi/ui/views/uye_giris_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class KisiDetaySayfa extends StatefulWidget {
  const KisiDetaySayfa({super.key});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var hastaID = "";
  var hasta_adsoyad = "";
  var hasta_mail = "";
  var hasta_tel = "";
  var hasta_resim = "";
  var hasta_bilgi = false;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> hastaBilgiKontrol() async {
    var sp = await SharedPreferences.getInstance();

    hasta_bilgi = sp.getBool("hasta_bilgi") ?? false;

    if (!hasta_bilgi) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UyeGirisSayfa()));
    }

    setState(() {
      hastaID = sp.getString("hastaID") ?? "yok";
      hasta_adsoyad = sp.getString("hasta_adsoyad") ?? "yok";
      hasta_mail = sp.getString("hasta_mail") ?? "yok";
      hasta_tel = sp.getString("hasta_tel") ?? "yok";
      hasta_resim = sp.getString("hasta_resim") ?? "yok";
    });
  }

  @override
  void initState() {
    super.initState();
    hastaBilgiKontrol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilim"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      hasta_resim.isNotEmpty
                          ? hasta_resim
                          : "https://tedavi.tahayasinkoksal.com.tr/assets/hastaResim/yok.png",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/profil_resim.png");
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Ad Soyad",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 5),
                Text(
                  hasta_adsoyad,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Mail",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 5),
                Text(
                  hasta_mail,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Telefon",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 5),
                Text(
                  hasta_tel,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    var sp = await SharedPreferences.getInstance();
                    setState(() {
                      sp.setBool("hasta_bilgi", false);
                      hastaBilgiKontrol();
                    });
                  },
                  child: Text(
                    "Çıkış Yap!",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "v1.0b",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 10),
                Text(
                  "Developer: Taha Yasin KÖKSAL",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text(
                    "www.tahayasinkoksal.com.tr",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    final Uri _url = Uri.parse('https://www.tahayasinkoksal.com.tr');
                    _launchUrl(_url);
                  },
                ),
                SizedBox(height: 5),
                GestureDetector(
                  child: Text(
                    "Linkedin: @tahayasinkoksal",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    final Uri _urlLinkedin = Uri.parse('https://tr.linkedin.com/in/tahayasinkoksal');
                    _launchUrl(_urlLinkedin);
                  },
                ),
                SizedBox(height: 5),
                GestureDetector(
                  child: Text(
                    "Github: @tahayasinkoksal",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    final Uri _urlGit = Uri.parse('https://github.com/tahayasinkoksal');
                    _launchUrl(_urlGit);
                  },
                ),
                SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
