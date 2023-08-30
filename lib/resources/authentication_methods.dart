import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/resources/cloudfirestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  // firebase instance
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //
  CloudFirestoreClass cloudFiresotreClass = CloudFirestoreClass();
  // kayıt methodu
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    // gelen datalardaki boşluklardan kurtulduk
    name.trim();
    address.trim();
    email.trim();
    password.trim();

    String output = "Something went wrong";

    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        // model'den kullanıcı oluşturduk
        UserDetailsModel user = UserDetailsModel(name: name, address: address);
        await cloudFiresotreClass.uploadNameAndAddressToDatabase(user: user);
        output = 'success';
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }

  // giriş methodu
  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    // gelen datalardaki boşluklardan kurtulduk
    email.trim();
    password.trim();

    String output = "Something went wrong";

    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = 'success';
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }
}
