import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/aktif_tedaviler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/biten_tedaviler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/eklemler_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/tedavi_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/uye_giris_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/cubit/uye_kayit_sayfa_cubit.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/ana_sayfa.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/introduction_screen.dart';
import 'package:bitirme_projesi_fizik_tedavi/ui/views/uye_giris_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatma

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen') ?? false;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(MyApp(seen: seen));
}

class MyApp extends StatelessWidget {
  final bool seen;

  const MyApp({super.key, required this.seen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UyeKayitSayfaCubit()),
        BlocProvider(create: (context) => UyeGirisSayfaCubit()),
        BlocProvider(create: (context) => EklemlerSayfaCubit()),
        BlocProvider(create: (context) => AktifTedavilerSayfaCubit()),
        BlocProvider(create: (context) => BitenTedavilerSayfaCubit()),
        BlocProvider(create: (context) => TedaviSayfaCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  seen ? const UyeGirisSayfa() : IntroductionScreenPage(),
      ),
    );
  }
}
