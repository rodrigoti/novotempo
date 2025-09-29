import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';

class AppConfig {
  static const String streamUrl = 'https://s05.w3bserver.com:20012/stream;';
  static const String androidId = 'br.com.rodrigoti.novotempo';
  static const String iOSId = 'xxxx';
}

Future<void> openUrl(url) async {
  final Uri _url = Uri.parse(url);
  try {
    await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    toast('Erro ao abrir');
  }
}

Future<void> share() async {
  if (Platform.isAndroid) {
    await Share.share(
        'Dá uma olhada nesse APP: https://play.google.com/store/apps/details?id=${AppConfig.androidId}');
  } else if (Platform.isIOS) {
    await Share.share(
        'Dá um aolhada nesse APP: https://apps.apple.com/us/app/');
  }
}

var ctime;
Future<bool> sair() async {
  DateTime now = DateTime.now();
  if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
    ctime = now;
    toast('Pressione mais uma vez para fechar o aplicativo');
    return false;
  }
  return true;
}

toast(txt) {
  Fluttertoast.showToast(
      toastLength: Toast.LENGTH_SHORT,
      msg: txt,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: Color.fromARGB(255, 174, 29, 0));
}

String removerAcentos(String str) {
  var comAcento =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var semAcento =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
  for (int i = 0; i < comAcento.length; i++) {
    str = str.replaceAll(comAcento[i], semAcento[i]);
  }
  return str;
}
