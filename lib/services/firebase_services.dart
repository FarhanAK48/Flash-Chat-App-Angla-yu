import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email already in use";
      } else if (e.code == "weak-password") {
        return "password is weak";
      }
      return "e.message";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "password is weak";
      }
      return "e.message";
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
//
// class FirebaseServices {
//   static Future<String?> createAccount(String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//   }
// }
