import 'package:amazon_clone_app/resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone_app/models/user_details_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;
  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: 'loading', address: 'loading');

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
