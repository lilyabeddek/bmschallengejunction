import 'package:flutter/material.dart';
import 'package:bmschallengejunction/Views/TypeRevendeur.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';
import 'package:bmschallengejunction/NewWidgets/Mission.dart';

class MesMissions extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MesMissions> {
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
          'Mes Missions',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Mission("Electricien", "Rue el moujahidine Douera, Alger", true),
            Mission("Grossiste", "Rue el moujahidine Douera, Alger", true),
            Mission("Quincaillerie", "Rue el moujahidine Douera, Alger", true),
            Mission("Electricien", "Rue el Rahmania Douera, Alger", false),
            Mission("Grossiste", "Rue el Rahmania Douera, Alger", false),
            Mission("Quincaillerie", "Rue el Rahmania Douera, Alger", false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TypeRevendeur(),
            ),
          ).then((value) => setState(() {}));
        },
        label: Text(
          'Nouveau Rapport',
          style: TextStyle(
            color: Color(0xff006579),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        icon: Icon(Icons.add, color: Color(0xff006579)),
        backgroundColor: Color(0xffffdd2e),
      ),
    );
  }
}
