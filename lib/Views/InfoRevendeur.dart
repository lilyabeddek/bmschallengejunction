import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:latlng/latlng.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bmschallengejunction/Views/DistributionRevendeur.dart';

class InfoRevendeur extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<InfoRevendeur> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  String initialCountry = 'DZ';
  PhoneNumber number = PhoneNumber(isoCode: 'DZ');
  bool valide = false;

  LatLng _center;
  String currentAddress;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  getUserLocation() async {
    Position currentLocation = await locateUser();
    final coordinates =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    print("${first.featureName} : ${first.addressLine}");
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
      currentAddress = "${first.featureName} : ${first.addressLine}";
    });
    print('position $currentLocation');
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //App Bar avec le titre
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: BackButton(),
        centerTitle: true,
        title: Text(
          'Informations du revendeur',
          style: TextStyle(
            color: Color.fromRGBO(34, 43, 69, 1),
            fontSize: 17,
          ),
        ),
      ),
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_rounded,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Localisation',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Lat : ' +
                  (_center.latitude != null
                      ? _center.latitude.toString()
                      : " ") +
                  ' Long : ' +
                  (_center.longitude != null
                      ? _center.longitude.toString()
                      : " "),
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            Text(
              currentAddress != null ? currentAddress : " ",
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            SizedBox(height: 10),
            //Nom
            Text(
              'Nom',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                // override textfield's icon color when selected
                primaryColor: Color.fromRGBO(78, 120, 236, 1),
              ),
              child: TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nom',
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
            SizedBox(height: 20),

            //Prenom
            Text(
              'Prenom',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                // override textfield's icon color when selected
                primaryColor: Color.fromRGBO(78, 120, 236, 1),
              ),
              child: TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Prenom',
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
            SizedBox(height: 20),
            Text(
              'Numéro de téléphone',
              style: TextStyle(
                color: Color.fromRGBO(34, 43, 69, 1),
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                // override textfield's icon color when selected
                primaryColor: Color.fromRGBO(78, 120, 236, 1),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber val) {
                  print(val.phoneNumber);
                  setState(() {
                    this.number = val;
                  });
                },
                onInputValidated: (bool value) {
                  print(value);
                  setState(() {
                    this.valide = value;
                  });
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
            SizedBox(
              height: 30,
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
                        builder: (context) => Distribution(),
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
