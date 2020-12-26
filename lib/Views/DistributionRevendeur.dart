import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';

class Distribution extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Distribution> {
  Map<String, bool> values = {
    'Tablier': false,
    'Bannière': false,
    'Sac': false,
    'Carnet': false,
    'Stylo': false,
  };
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CollapsingNavigationDrawer(),

      //App Bar avec le titre
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: BackButton(),
        centerTitle: true,
        title: Text(
          'Distribution',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
        height: 450,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: ListView(
          children: <Widget>[
                Text("Cochez un ou plusieurs choix :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 10,
                ),
              ] +
              values.keys.map((String key) {
                return new CheckboxListTile(
                  title: new Text(key),
                  value: values[key],
                  onChanged: (bool value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList() +
              [
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    height: 40,
                    minWidth: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      child:
                          const Text('Suivant', style: TextStyle(fontSize: 17)),
                      color: Color(0xffffdd2e),
                      textColor: Color(0xff006579),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
