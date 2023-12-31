import 'dart:typed_data';

import 'package:amazon_clone_app/models/order_requests_model.dart';
import 'package:amazon_clone_app/models/product_model.dart';
import 'package:amazon_clone_app/models/review_model.dart';
import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase({
    required UserDetailsModel user,
  }) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data()) as dynamic,
    );
    // print(snap.data());
    return userModel;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();

    //
    String output = 'Something went wrong';

    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();

        String url = await uploadImageToDatabase(
          image: image,
          uid: Utils().getUid(),
        );
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));

        //
        ProductModel productModel = ProductModel(
            imgUrl: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        await firebaseFirestore
            .collection('products')
            .doc(uid)
            .set(productModel.getJson());
        output = 'success';
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = 'Please fill all fields';
    }

    return output;
  }

  //
  Future<String> uploadImageToDatabase({
    required Uint8List image,
    required String uid,
  }) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('products').child(uid);

    UploadTask uploadTask = storageRef.putData(image);

    TaskSnapshot taskSnapshot = await uploadTask;

    return taskSnapshot.ref.getDownloadURL();
  }

  //
  Future<List<Widget>> getProductsFromDsicount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('products')
        .where('discount', isEqualTo: discount)
        .get();

    for (var i = 0; i < snapshot.docs.length; i++) {
      DocumentSnapshot docSnap = snapshot.docs[i];

      ProductModel productModel =
          ProductModel.getModelFromJson(json: docSnap.data() as dynamic);

      children.add(SimpleProductWidget(productModel: productModel));
    }

    return children;
  }

  Future uploadReviewToDatabase({
    required String productUid,
    required ReviewModel reviewModel,
  }) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection('reviews')
        .add(reviewModel.getJson());

    await changeAvgRating(
      productUid: productUid,
      reviewModel: reviewModel,
    );
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({
    required UserDetailsModel userDetailsModel,
  }) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .get();

    for (var i = 0; i < snapshot.docs.length; i++) {
      ProductModel productModel =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());

      addProductsToOrders(
        productModel: productModel,
        userDetailsModel: userDetailsModel,
      );
      await deleteProductFromCart(
        uid: productModel.uid,
      );
    }
  }

  Future addProductsToOrders({
    required ProductModel productModel,
    required UserDetailsModel userDetailsModel,
  }) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('orders')
        .add(productModel.getJson());

    await sendOrderRequest(
        productModel: productModel, userDetailsModel: userDetailsModel);
  }

  Future sendOrderRequest({
    required ProductModel productModel,
    required UserDetailsModel userDetailsModel,
  }) async {
    OrderRequestsModel orderRequestsModel = OrderRequestsModel(
      orderName: productModel.productName,
      buyersAddress: userDetailsModel.address,
    );

    await firebaseFirestore
        .collection('users')
        .doc(productModel.sellerUid)
        .collection('orderRequests')
        .add(orderRequestsModel.getJson());
  }

  Future changeAvgRating({
    required String productUid,
    required ReviewModel reviewModel,
  }) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productUid)
        .get();

    ProductModel productModel =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));

    int currentRating = productModel.rating;
    int newRating = (currentRating + reviewModel.rating) ~/ 2;

    await FirebaseFirestore.instance
        .collection('products')
        .doc(productUid)
        .update({'rating': newRating});
  }
}
