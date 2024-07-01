import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/uye_giris_sayfa.dart';

class IntroductionScreenPage extends StatelessWidget {
  Future<void> _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const UyeGirisSayfa()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Akıllı Fizik Tedavi",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white, // AppBar arka plan rengini beyaz yapıyoruz
        iconTheme: IconThemeData(color: Colors.black), // İkonların rengini siyah yapıyoruz
        titleTextStyle: TextStyle(color: Colors.black), // Başlık metninin rengini siyah yapıyoruz
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white, // Arka plan rengini beyaz yapıyoruz
        pages: [
          PageViewModel(
            title: "Sana Özel",
            body: "Senin için oluşturulan tamamen sana özel tedavi planı",
            image: Image.asset('assets/tanitimResim/img1.jpg'),
          ),
          PageViewModel(
            title: "Kontrol Sende!",
            body: "Ne zaman nerede istersen tedaviye katılabilirsin",
            image: Image.asset('assets/tanitimResim/img2.jpg'),
          ),
          PageViewModel(
            title: "Güvenli",
            body: "Tedavi bilgilerin senin ve doktorun dışında kimse erişemez!",
            image: Image.asset('assets/tanitimResim/img3.jpg'),
          ),
          PageViewModel(
            title: "Kimseye Bağlı Kalma",
            body: "Kendini iyi hissettiğinde başlayabilirsin",
            image: Image.asset('assets/tanitimResim/img1.jpg'),
          )
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        showSkipButton: true,
        skip: const Text("Geç"),
        next: const Icon(Icons.arrow_forward),
        done: const Text("Başlayalım", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
