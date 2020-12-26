//import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';
import 'package:bmschallengejunction/Services/ContactService.dart';
import 'package:bmschallengejunction/globals.dart' as globals;

import 'package:bmschallengejunction/NewWidgets/Dialogs.dart';

class ContactezNous extends StatefulWidget {
  @override
  _ContactezNousState createState() => _ContactezNousState();
}

class _ContactezNousState extends State<ContactezNous> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final formKey = GlobalKey<FormState>();
  String objet, message;

  validationEnvoie(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 340,
            width: 200,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Color(0xff80b265),
                  size: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Merci',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    width: 250,
                    height: 1,
                    color: Color(0xffffdd2e)),
                Center(
                  child: Text(
                    'Votre Feedback à bien été enregistré et sera pris en consideration dés que possible !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
            'Contactez Nous',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
            ),
          ),
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
                  //Objet du message
                  Text(
                    'Objet',
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'objet de votre message',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          this.objet = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),

                  //Message à envoyer
                  Text(
                    'Message',
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
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Saisissez votre message...',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Champ obligatoire";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          this.message = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text('Envoyer'),
                      color: Color(0xffffdd2e),
                      textColor: Color(0xff006579),
                      onPressed: () async {
                        if (!formKey.currentState.validate()) {
                          return;
                        }
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        await ContactService().setFeedback(objet, message);
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        validationEnvoie(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
