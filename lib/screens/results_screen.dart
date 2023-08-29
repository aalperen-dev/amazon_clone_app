// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../utils/constants.dart';
import '../widgets/results_widget.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              15,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Showing results for ',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: query,
                    style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                return ResultWidget(
                  product: ProductModel(
                      imgUrl: amazonLogoUrl,
                      productName: 'deneme',
                      cost: 9.9,
                      discount: 50,
                      uid: 'asddd',
                      sellerName: 'dddd',
                      sellerUid: 'asdd',
                      rating: 4,
                      noOfRating: 4),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
