import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'new_version_plus.dart';
import 'home.dart';


void main() => {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffBFE5FE), // navigation bar color
      statusBarColor: Color(0xffC9E3FC),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  WidgetsFlutterBinding.ensureInitialized(),
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(NewVersionPlus())),
};

class NewVersionPlus extends StatelessWidget {
  const NewVersionPlus({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          // Chama o update checker aqui, com contexto já válido
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppVersionChecker.checkAndPromptUpdate(context);
          });
          return Inicio();
        },
      ),
    );
  }
}
