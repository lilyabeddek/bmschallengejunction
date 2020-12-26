import 'package:bmschallengejunction/Views/TypeRevendeur.dart';
import 'package:bmschallengejunction/Views/DistributionRevendeur.dart';
import 'package:bmschallengejunction/Views/InfoRevendeur.dart';
import 'package:bmschallengejunction/Views/MesRapports.dart';
import 'package:bmschallengejunction/Views/MesMissions.dart';
import 'package:bmschallengejunction/Views/APropos.dart';
import 'package:bmschallengejunction/Views/ContactezNous.dart';
import 'package:bmschallengejunction/Views/CompteUtilisateur.dart';
import 'package:bmschallengejunction/Views/Ouverture.dart';
import 'package:bmschallengejunction/Views/Aide.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMS App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Ouverture(),
      routes: {
        '/MesRapports': (_) => MesRapports(),
        '/MesMissions': (_) => MesMissions(),
        '/APropos': (_) => APropos(),
        '/ContactezNous': (_) => ContactezNous(),
        '/Compte': (_) => CompteUtilisateur(),
        '/Aide': (_) => Aide(),
      },
    );
  }
}
