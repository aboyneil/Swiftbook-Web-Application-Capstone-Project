import 'package:admin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin/services/database.dart';
import 'package:admin/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:admin/screens/Account/components/generate_pwd.dart';

import 'logs_database.dart';

class AuthService {
  //final - not gonna change in the future
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LogsService _logs = LogsService();

  //creates a user object based on FirebaseUser (User?)
  Users _userFromFirebaseUser(User user) {
    /*
    if (user != null) {
      return Users(uid: user.uid);
    } else {
      return null;
    }
    */
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser);
  }

  //sign in anon
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email & pass
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      if (email == userEmail && userCompany == company) {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User user = result.user;
        _logs.addLogs('Login');
        return _userFromFirebaseUser(user);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & pass
  Future registerWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //insert personal info in firestore
      await DatabaseService(uid: user.uid)
          .updateUserdata(fullname, email, username, job_access, company);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _logs.addLogs('Logout');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> registerInsideWeb(String email, String password) async {
    var result = null;
    FirebaseApp app = await Firebase.initializeApp(
        name: generateNameApp(), options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
      result = await FirebaseAuth.instanceFor(app: app).currentUser.uid;
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    await app.delete();
    return result;
  }

  Future resetPassword(String ForgotPass) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      return await auth.sendPasswordResetEmail(email: ForgotPass);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
