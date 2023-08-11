import 'dart:io';

import 'package:finalproject/core/values/colors.dart';
import 'package:finalproject/routes/pages_binding.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E Learning',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        fontFamily: '',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Pages.pages,
    );
  }
}

/// To handle Error: HandshakeException: Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: certificate has expired(handshake.cc:393))
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
