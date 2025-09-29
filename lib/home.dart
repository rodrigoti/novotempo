import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

import 'funcoes.dart';
import 'package:http/http.dart' as http;

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  //

  RadioPlayer radioPlayer = RadioPlayer();
  List<String>? metadata;
  bool isPlaying = false;
  bool isLoad = false;
  Widget icon = Image.asset(
    "assets/play.png",
  );

  Widget Titulo = Text(
    'Rádio Novo Tempo Pernambuco',
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontSize: 19, color: Color(0xffcc2200), fontWeight: FontWeight.w700),
  );

  void initState() {
    super.initState();

    radioPlayer.setChannel(
        title: 'Rádio Novo Tempo Pernambuco',
        url: AppConfig.streamUrl,
        imagePath: 'assets/logo.png');

    radioPlayer.stateStream.listen((value) {
      isPlaying = value;
      setState(() {
        if (isPlaying) {
          icon = Image.asset(
            "assets/pause.png",
          );
        } else
          icon = Image.asset(
            "assets/play.png",
          );
      });
    });

    radioPlayer.metadataStream.listen((value) {
      setState(() {
        if (value[0] != '') {
          Titulo = Column(children: [
            Text(
              value[0],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 19,
                  color: Color(0xffcc2200),
                  fontWeight: FontWeight.w700),
            ),
            if (value[1] != '') ...{
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  value[1],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffcc2200),
                      fontWeight: FontWeight.w500),
                ),
              ),
            }
          ]);
        }
      });
    });
  }

  play() {
    isPlaying ? radioPlayer.stop() : radioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Novo Tempo',
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: WillPopScope(
          onWillPop: () => sair(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Column(children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 280,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 60,
                                child: Titulo,
                              ),
                              Container(
                                height: 100,
                                child: GestureDetector(
                                  child: icon,
                                  onTap: () => play(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Image.asset(
                                  "assets/insta.png",
                                  width: 55,
                                ),
                                onTap: () => openUrl(
                                    'https://www.instagram.com/rntpe17'),
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/face.png",
                                  width: 55,
                                ),
                                onTap: () => openUrl(
                                    'https://www.facebook.com/novotempopernambuco'),
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/whats.png",
                                  width: 75,
                                ),
                                onTap: () => openUrl(
                                    'whatsapp://send?phone=5587981071237'),
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/twitter.png",
                                  width: 55,
                                ),
                                onTap: () => openUrl(
                                    'https://www.twitter.com/radio_tempo'),
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/site.png",
                                  width: 55,
                                ),
                                onTap: () =>
                                    openUrl('https://www.radiontpe.com.br/'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
