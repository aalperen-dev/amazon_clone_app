import 'package:amazon_clone_app/models/product_model.dart';
import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/providers/user_details_provider.dart';
import 'package:amazon_clone_app/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/cart_item_widget.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:amazon_clone_app/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                          color: yellowColor,
                          isLoading: true,
                          onPressed: () {},
                          child: const Text(
                            'Loading',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      } else {
                        return CustomMainButton(
                          color: yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFirestoreClass().buyAllItemsInCart(
                              userDetailsModel:
                                  Provider.of<UserDetailsProvider>(
                                context,
                                listen: false,
                              ).userDetails,
                            );
                            Utils().showSnakBar(
                                context: context, content: 'done!');
                          },
                          child: Text(
                            'Proceed to buy (${snapshot.data!.docs.length}) items',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // sepetdeki ürünler
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel productModel =
                                ProductModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return CartItemWidget(product: productModel);
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
            const UserDetailsBar(
              offset: 0,
              // userDetails: UserDetailsModel(name: 'alp', address: 'test'),
            ),
          ],
        ),
      ),
    );
  }
}
