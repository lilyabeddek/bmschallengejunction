import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Mission extends StatefulWidget {
  final String titre;
  final String soustitre;
  final bool done;
  Mission(this.titre, this.soustitre, this.done);
  @override
  _MissionState createState() =>
      _MissionState(this.titre, this.soustitre, this.done);
}

class _MissionState extends State<Mission> {
  final String titre;
  final String soustitre;
  final bool done;
  _MissionState(this.titre, this.soustitre, this.done);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: done ? Color(0xff80b265).withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: done ? Color(0xff80b265) : Colors.grey,
        ),
      ),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xff006579),
            ),
            child: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
