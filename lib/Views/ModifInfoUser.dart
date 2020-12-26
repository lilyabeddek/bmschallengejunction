import 'package:flutter/material.dart';
import 'package:bmschallengejunction/globals.dart' as globals;
import 'package:bmschallengejunction/Services/UserService.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';

class ModifInfoUser extends StatefulWidget {
  @override
  _ModifInfoUserState createState() => _ModifInfoUserState();
}

class _ModifInfoUserState extends State<ModifInfoUser> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nomController =
      TextEditingController(text: globals.nomUser);
  final TextEditingController _prenomController =
      TextEditingController(text: globals.prenomUser);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: CollapsingNavigationDrawer(),
        //App Bar avec le titre
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Color.fromRGBO(34, 43, 69, 1),
          ),
          //centerTitle: true,
          title: Text(
            'Modifier mes informations',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'Valider',
                style: TextStyle(fontSize: 18),
              ),
              color: Colors.white,
              textColor: Color(0xff006579),
              onPressed: () async {
                if (!formKey.currentState.validate()) {
                  return;
                }
                await UserService().updateUserInfos(
                    _nomController.text, _prenomController.text);

                globals.nomUser = _nomController.text;
                globals.prenomUser = _prenomController.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),

        // Contenu de la page
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Nom
                  Text(
                    'Nom',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color(0xff80b265),
                    ),
                    child: TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Votre Nom',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  //Prenom
                  Text(
                    'Prénom',
                    style: TextStyle(
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color(0xff80b265),
                    ),
                    child: TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Votre Prénom',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
