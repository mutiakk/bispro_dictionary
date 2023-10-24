
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterdict/page/list_page.dart';

import 'fonts.dart';
import 'page/list_pageLaw.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamus English',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime? lastPressed;
  void _out(context, bool mantap) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          elevation: 24,
          title: Text("Do you want to quit?",
              maxLines: 2,
              textAlign: TextAlign.left),

          actions: <Widget>[
            TextButton(
              style:
              TextButton.styleFrom(backgroundColor: Color(0xffE5E5E5)),
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal[800]),
                onPressed: () {
                  setState(() {
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  });
                },
                child: const Text('OK',
                    style: TextStyle(
                        fontFamily: "NunitoSans", color: Colors.white)))
          ],
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope (onWillPop:() async {
          final now = DateTime.now();
          final maxDuration = Duration(seconds: 2);
          final isWarning = lastPressed == null ||
              now.difference(lastPressed!) > maxDuration;

          if (isWarning) {
            lastPressed = DateTime.now();

            final snackBar = SnackBar(
              content: Text('Double Tap To Close App'),
              duration: maxDuration,
            );

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(snackBar);

            return false;
          } else {
            _out(context, true);
            return true;
          }},
          child:Container(
              width: double.infinity, // Set width as needed
              height: double.infinity, // Set height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('pict/wp2.png'), // Replace with your image path
                  fit: BoxFit.fitHeight, // Adjust the fit as needed
                ),
              ),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Official Application of \n English for Business and Professional Communication\n PNJ V.1.0',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Business and Legal Glossaries',style: ThemeFonts.textApk
                              .copyWith(fontSize: 30,color: Colors.teal[700]),textAlign: TextAlign.center,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Tombol pertama
                            ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                primary: Colors.teal[500],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding tombol
                                fixedSize: Size(150, 150), // Ukuran minimal tombol
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ListWord()),
                                );
                                // Aksi yang akan dijalankan saat tombol pertama ditekan
                                print('Tombol Pertama Ditekan!');
                              },
                              child: Text('Business\nGlossaries',maxLines: 2,textAlign: TextAlign.center,),
                            ),
                            // Tombol kedua
                            ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                primary: Colors.teal[500],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding tombol
                                minimumSize: Size(150, 150), // Ukuran minimal tombol
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ListPageLaw()),
                                );
                                // Aksi yang akan dijalankan saat tombol pertama ditekan
                                print('Tombol Pertama Ditekan!');
                              },
                              child: Text('Legal\nGlossaries',maxLines: 2,textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), //centerObject()),
                )],
            ),
          ),
        ));
  }
}

