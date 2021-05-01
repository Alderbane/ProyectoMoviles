import 'package:firebase_auth/firebase_auth.dart';

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
            email: email, password: password))
        .user;
    await user.updateProfile(displayName: name);
    await user.reload();
  }

  Future<void> emailSignIn(String email, String password) async {
    final user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    await user.reload();
  }
}
