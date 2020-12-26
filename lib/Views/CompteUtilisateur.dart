import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bmschallengejunction/commons/collapsing_navigation_drawer_widget.dart';
import 'package:bmschallengejunction/globals.dart' as globals;

import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:bmschallengejunction/NewWidgets/profile_list_item.dart';
import 'package:bmschallengejunction/Views/SeConnecter.dart';
import 'package:bmschallengejunction/Services/UserService.dart';
import 'package:bmschallengejunction/Views/ModifInfoUser.dart';
import 'package:bmschallengejunction/Views/ModifMotPasse.dart';

import 'package:share/share.dart';

// ignore: must_be_immutable
class CompteUtilisateur extends StatefulWidget {
  List data;
  int iTId;
  CompteUtilisateur({this.data, this.iTId});
  @override
  AttachmentState createState() => new AttachmentState();
}

class AttachmentState extends State<CompteUtilisateur> {
  File _image;

  Future<String> uploadFile(File _image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Photo/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    print(returnURL);
    return returnURL;
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    await _cropImage(image);
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    await _cropImage(image);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("Galerie"),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text("Appareil Photo"),
                    onTap: () async {
                      await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text("Supprimer la Photo"),
                    onTap: () {
                      _clearImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                /*CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9*/
              ]
            : [
                //CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                /*CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9*/
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Ajustez l'image",
            toolbarColor: Color(0xff317ac1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: "Ajustez l'image",
        ));
    if (croppedFile != null) {
      setState(() {
        _image = croppedFile;
      });
      String url = await uploadFile(croppedFile);
      setState(() {
        globals.photoUser = url;
      });
    } else {
      setState(() {
        _image = image;
      });
      String url = await uploadFile(image);
      setState(() {
        globals.photoUser = url;
      });
    }
    UserService().updateUserPhoto(globals.photoUser);
  }

  void _clearImage() {
    setState(() {
      _image = null;
      globals.photoUser = "";
    });
    UserService().updateUserPhoto(globals.photoUser);
  }

  @override
  Widget build(BuildContext context) {
    globals.selectedListTile = 7;
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
            'Gérer mon Compte',
            style: TextStyle(
              color: Color.fromRGBO(34, 43, 69, 1),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 30),
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xff317ac1),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                : globals.photoUser != ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                          image: NetworkImage(
                                            globals.photoUser,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 10 * 2.5,
                              width: 10 * 2.5,
                              decoration: BoxDecoration(
                                color: Color(0xff80b265),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                heightFactor: 10 * 1.5,
                                widthFactor: 10 * 1.5,
                                child: Icon(
                                  LineAwesomeIcons.pen,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    globals.nomUser + " " + globals.prenomUser,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    globals.numTel,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(34, 43, 69, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModifInfoUser(),
                  ),
                ).then((value) => setState(() {}));
              },
              child: ProfileListItem(
                icon: Icons.person, //LineAwesomeIcons.user_shield,
                text: 'Modifier mon profil',
              ),
            ),
            InkWell(
              onTap: () {},
              child: ProfileListItem(
                icon: Icons.notifications, //LineAwesomeIcons.bell,
                text: 'Son et notifications',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModifMotPasse(false),
                  ),
                ).then((value) => setState(() {}));
              },
              child: ProfileListItem(
                icon:
                    Icons.verified_user_rounded, //LineAwesomeIcons.user_shield,
                text: 'Confidentialité',
              ),
            ),
            InkWell(
              onTap: () {},
              child: ProfileListItem(
                icon: Icons.help, //LineAwesomeIcons.question_circle,
                text: 'Aide et Support',
              ),
            ),
            InkWell(
              onTap: () {
                showAlertDialog(context);
              },
              child: ProfileListItem(
                icon: Icons.exit_to_app, //LineAwesomeIcons.alternate_sign_out,
                text: 'Déconnexion',
                hasNavigation: false,
              ),
            ),
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
