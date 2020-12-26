import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmschallengejunction/Views/InfoRevendeur.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';

enum SingingCharacter { electricien, quincaillerie, grossiste }

class TypeRevendeur extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TypeRevendeur> {
  SingingCharacter _character = SingingCharacter.electricien;
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
          'Type du revendeur',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
        height: 350,
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
        child: Column(
          children: <Widget>[
            Text(
              "Ce revendeur est-il?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text('Eléctricien'),
              leading: Radio(
                value: SingingCharacter.electricien,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Grossiste'),
              leading: Radio(
                value: SingingCharacter.grossiste,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Quincaillerie'),
              leading: Radio(
                value: SingingCharacter.quincaillerie,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonTheme(
                height: 40,
                minWidth: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoRevendeur(),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: const Text('Suivant', style: TextStyle(fontSize: 17)),
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
