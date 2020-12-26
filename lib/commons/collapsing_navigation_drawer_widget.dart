import 'package:bmschallengejunction/Views/SeConnecter.dart';

import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bmschallengejunction/globals.dart' as globals;
import 'package:bmschallengejunction/Services/AuthService.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 300;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = globals.selectedListTile;
  int preSelectedIntex;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    List<NavigationModel> navigationItems = [
      NavigationModel(
        title: "Mes rapports",
        icon: Icons.home,
        chemin: '/MesRapports',
      ),
      NavigationModel(
          title: "Mes missions", icon: Icons.file_copy, chemin: '/MesMissions'),
      NavigationModel(
        title: "A propos",
        icon: Icons.info,
        chemin: '/APropos',
      ),
      NavigationModel(
          title: "Contactez Nous",
          icon: Icons.message,
          chemin: '/ContactezNous'),
      NavigationModel(
        title: "Se déconnecter",
        icon: Icons.exit_to_app,
        chemin: '',
      ),
    ];
    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: Color(0xff097185),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/BMS@4x.png'),
                    height: 50,
                    width: 150,
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
                    height: 12.0,
                    color: Colors.transparent,
                  );
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      preSelectedIntex = currentSelectedIndex;
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                      globals.selectedListTile = counter;
                      if (navigationItems[counter].title != 'Se déconnecter') {
                        Navigator.of(context)
                            .pushNamed(navigationItems[counter].chemin);
                      } else {
                        showAlertDialog(context);
                        setState(() {
                          currentSelectedIndex = preSelectedIntex;
                        });
                        globals.selectedListTile = preSelectedIntex;
                      }
                    },
                    isSelected: currentSelectedIndex == counter,
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          globals.selectedListTile = 7;
                          Navigator.of(context).pushNamed('/Compte');
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromRGBO(78, 120, 236, 1),
                          child: globals.photoUser != ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        globals.photoUser,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 100,
                                  height: 100,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(100)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(globals.prenomUser,
                              style: listTitleDefaultTextStyle),
                          Text(globals.nomUser, style: sousTitre),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.help,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Aide');
                    },
                  ),
                ],
              ),
            ),
            /* Checkbox(
                value: themeChange.darkTheme,
                onChanged: (bool value) {
                  themeChange.darkTheme = value;
                })*/
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            height: 350,
            width: 200,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Color(0xffffdd2e),
                  size: 80,
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    'Etes-vous sûr de vouloir vous déconnecter ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeConnecter(),
                          ),
                        );
                      },
                      child: Text(
                        "Oui",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color(0xff006579),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Non",
                        style: TextStyle(
                          color: Color(0xff006579),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
