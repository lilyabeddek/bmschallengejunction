import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bmschallengejunction/globals.dart' as globals;

class ContactService {
  final CollectionReference feedbacks =
      FirebaseFirestore.instance.collection('Feedback');
  setFeedback(String objet, String message) {
    return feedbacks
        .add({'objet': objet, 'message': message, 'user': globals.idUser})
        .then((value) => print("Feedback Added"))
        .catchError((error) => print("Failed to add Feedback: $error"));
  }
}
