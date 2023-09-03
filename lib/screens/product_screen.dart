// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_app/models/review_model.dart';
import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/cost_widget.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone_app/widgets/rating_star_widget.dart';
import 'package:amazon_clone_app/widgets/review_dialog.dart';
import 'package:amazon_clone_app/widgets/review_widget.dart';
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:amazon_clone_app/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone_app/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceTool = Expanded(child: Container());

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height -
                          (kAppBarHeight + (kAppBarHeight / 2)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ürün ve satıcı bilgisi
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // satıcı adı
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.productModel.sellerName,
                                        style: const TextStyle(
                                          color: activeCyanColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    // ürün adı
                                    Text(widget.productModel.productName),
                                  ],
                                ),
                                // ürün rating
                                RatingStarWidget(
                                  rating: widget.productModel.rating,
                                ),
                              ],
                            ),
                          ),

                          // ürün resmi
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: screenSize.height / 3.5,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 3),
                              child: Image.network(widget.productModel.imgUrl),
                            ),
                          ),
                          //
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          //
                          spaceTool,
                          // fiyat bilgisi
                          CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost,
                          ),
                          spaceTool,
                          // satın al
                          CustomMainButton(
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: () {},
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceTool,
                          // sepete ekle
                          CustomMainButton(
                            color: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              // ürünü sepete ekleme

                              await CloudFirestoreClass().addProductToCart(
                                productModel: widget.productModel,
                              );

                              Utils().showSnakBar(
                                  context: context, content: 'Added to cart!');
                            },
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          spaceTool,
                          // yorum ekleme
                          CustomSimpleRoundedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ReviewDialog(
                                      productUid: widget.productModel.uid,
                                    );
                                  },
                                );
                              },
                              text: 'Add a review for this product'),
                        ],
                      ),
                    ),
                    // değerlendirme
                    SizedBox(
                      height: screenSize.height,
                      // height: 20,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.productModel.uid)
                            .collection('reviews')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ReviewModel reviewModel =
                                    ReviewModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());

                                return ReviewWidget(review: reviewModel);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
