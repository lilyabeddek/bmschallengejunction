import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';
import 'package:bmschallengejunction/globals.dart' as globals;

class Aide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globals.selectedListTile = 8;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CollapsingNavigationDrawer(),
      //App Bar avec le titre
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Color.fromRGBO(34, 43, 69, 1),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Aide',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
