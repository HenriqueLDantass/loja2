import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trocapc/modules/auth/pages/login_page.dart';
import 'package:trocapc/modules/auth/stores/registro_store.dart';
import 'package:trocapc/modules/home/stores/home_stores.dart';
import 'package:trocapc/modules/splash/pages/splashscreen_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeStore>(
            create: (_) => HomeStore(),
          ),
          ChangeNotifierProvider<RegistroStore>(
            create: (_) => RegistroStore(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'loja online',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreenPage(),
        ));
  }
}
