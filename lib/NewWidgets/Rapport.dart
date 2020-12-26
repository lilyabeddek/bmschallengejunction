import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Rapport extends StatefulWidget {
  final String titre;
  final String soustitre;
  Rapport(this.titre, this.soustitre);
  @override
  _RapportState createState() => _RapportState(this.titre, this.soustitre);
}

class _RapportState extends State<Rapport> {
  final String titre;
  final String soustitre;
  _RapportState(this.titre, this.soustitre);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
          )),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titre,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                soustitre,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.check_circle,
              color: Color(0xff80b265),
            ),
          ),
        ],
      ),
    );
  }
}
