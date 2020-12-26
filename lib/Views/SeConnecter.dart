import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:bmschallengejunction/Services/UserService.dart';
import 'package:bmschallengejunction/Views/MesRapports.dart';
import 'package:bmschallengejunction/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bmschallengejunction/NewWidgets/Dialogs.dart';

class SeConnecter extends StatefulWidget {
  @override
  _SeConnecterState createState() => _SeConnecterState();
}

class _SeConnecterState extends State<SeConnecter> {
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'DZ');
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: globals.textDirectionValue,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,

        //App Bar avec le titre
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            titleSpacing: 0.0,
            leadingWidth: 20,
            leading: BackButton(),
            title: Text(
              'Se Connecter',
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Theme(
                    data: Theme.of(context).copyWith(
                      // override textfield's icon color when selected
                      primaryColor: Color(0xff80b265),
                    ),
                    child: InternationalPhoneNumberInput(
                      hintText: 'Numéro de téléphone',
                      onInputChanged: (PhoneNumber val) {
                        print(val.phoneNumber);
                        setState(() {
                          this.number = val;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        backgroundColor: Colors.white,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(isoCode: 'DZ'),
                      textFieldController: phonecontroller,
                      inputBorder: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: Color(0xff80b265),
                    ),
                    child: TextFormField(
                      obscureText: !passwordVisible,
                      controller: _mdpController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Mot de passe',
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
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
                  SizedBox(height: 40),
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 42,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      color: Color(0xffffdd2e),
                      textColor: Color(0xff006579),
                      onPressed: () async {
                        if (!formKey.currentState.validate()) {
                          return;
                        }

                        Dialogs.showLoadingDialog(context, _keyLoader);
                        QueryDocumentSnapshot user = await UserService()
                            .getUser(number.phoneNumber != null
                                ? number.phoneNumber
                                : "");
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        if (user != null) {
                          print("User existe");
                          if (user.data()["motDePasse"] !=
                              _mdpController.text) {
                            setState(() {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Mot de passe erroné"),
                                duration: Duration(seconds: 2),
                              ));
                            });
                            print("mot de passe ghalte");
                          } else {
                            setState(() {
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Authentifié avec succés"),
                                duration: Duration(seconds: 2),
                              ));
                            });
                            print("mot de passe shih");
                            globals.idUser = user.id;
                            globals.nomUser = user.data()['nom'];
                            globals.prenomUser = user.data()['prenom'];
                            globals.photoUser = user.data()['photo'];
                            globals.numTel = user.data()['numTel'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MesRapports(),
                              ),
                            );
                          }
                        } else {
                          setState(() {
                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "Aucun compte n'existe avec ce numéro de téléphone"),
                              duration: Duration(seconds: 2),
                            ));
                          });
                          print("User n'existe pas");
                        }
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Mot de passe oublié',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      color: Colors.white,
                      textColor: Colors.white,
                      onPressed: () async {
                        Dialogs.showLoadingDialog(context, _keyLoader);
                        QueryDocumentSnapshot user = await UserService()
                            .getUser(number.phoneNumber != null
                                ? number.phoneNumber
                                : "");
                        Navigator.of(_keyLoader.currentContext,
                                rootNavigator: true)
                            .pop();
                        if (user != null) {
                          print("User existe");

                          globals.idUser = user.id;
                          globals.nomUser = user.data()['nom'];
                          globals.prenomUser = user.data()['prenom'];
                          globals.photoUser = user.data()['photo'];
                          globals.numTel = user.data()['numTel'];
                        } else {
                          setState(() {
                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  "Numéro de téléphone invalide ou compte inexistant"),
                              duration: Duration(seconds: 2),
                            ));
                          });
                        }
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
