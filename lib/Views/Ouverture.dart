import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmschallengejunction/Views/PageSliderInfoApp.dart';

class Ouverture extends StatefulWidget {
  @override
  OuvertureState createState() => OuvertureState();
}

class OuvertureState extends State<Ouverture> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PageSliderInfoApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xff097185),
        child: Center(
          child: Image(
            image: AssetImage('assets/images/BMS@4x.png'),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
