import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAlreadyLogged() {
    var user = FirebaseAuth.instance.currentUser;
    //print("User: ${user.displayName}");
    return user != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> emailSignUp(String name, String email, String password) async {
    final user = (await _auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim()))
        .user;
    await user.updateProfile(displayName: name);
    await user.reload();
    String notificationToken = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('usuarios').doc(_auth.currentUser.uid).update({"token": notificationToken});
  }

  Future<void> emailSignIn(String email, String password) async {
    final user = (await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim()))
        .user;
    await user.reload();
    String notificationToken = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('usuarios').doc(_auth.currentUser.uid).update({"token": notificationToken});
    
  }
}
