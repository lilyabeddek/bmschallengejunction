import 'package:flutter/material.dart';
import 'package:bmschallengejunction/globals.dart' as globals;

import 'package:bmschallengejunction/Views/SeConnecter.dart';

class PageSliderInfoApp extends StatefulWidget {
  @override
  _PageSliderInfoAppState createState() => _PageSliderInfoAppState();
}

class _PageSliderInfoAppState extends State<PageSliderInfoApp> {
  final _controller = new PageController(initialPage: 0);
  static const kAnimationDuration = Duration(milliseconds: 200);
  final _kArrowColor = Colors.black.withOpacity(0.8);
  int currentPage = 0;

  Container itemPageView(
      String assetImage, String textImage, String sousTitreImage) {
    return Container(
      //constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color(0xff006579).withOpacity(0.2),
              Color(0xff006579),
            ],
            stops: [0.0, 0.9],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: Text(
                textImage,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20, left: 20, bottom: 180),
              child: Text(
                sousTitreImage,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      itemPageView(
        'assets/images/agent_marketing.jpg',
        "Faites vos investigations !",
        "Localisez, Catégorisez, évaluez et suivez vos rapports ",
      ),
      itemPageView(
        'assets/images/agent_marketing.jpg',
        "Localisez de maniere précise",
        "Obtenez la localisation exact des revendeurs !",
      ),
      itemPageView(
        'assets/images/agent_marketing.jpg',
        "Information disponible en temps réel",
        "Quelque secondes séparent l'evoir du rapport et sa disponibilité sur Tableaux de bord",
      ),
    ];
    return Scaffold(
      body: IconTheme(
        data: IconThemeData(color: _kArrowColor),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(20.0),
                height: 160,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Connectez-vous!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          currentPage == 2 ? 'Commencer' : 'Suivant',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        color: Color(0xffffdd2e),
                        textColor: Color(0xff006579),
                        onPressed: () {
                          currentPage != 2
                              ? setState(() {
                                  _controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linearToEaseOut);
                                })
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeConnecter()),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Color(0xff80b265) : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
