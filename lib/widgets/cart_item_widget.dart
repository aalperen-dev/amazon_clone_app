// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone_app/widgets/custom_square_button.dart';
import 'package:amazon_clone_app/widgets/product_info_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(25),
      height: (screenSize.height / 2) + 10,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ürün resmi
                SizedBox(
                  width: screenSize.width / 3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      largeAds[1],
                    ),
                  ),
                ),
                // ürün bilgileri
                const ProductInfoWidget(
                  productName: 'test',
                  cost: 15.05,
                  sellerName: 'deneme',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                // eksiltme
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(
                    Icons.remove,
                  ),
                ),
                // adet
                CustomSquareButton(
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 40,
                  child: const Text(
                    '0',
                    style: TextStyle(
                      color: activeCyanColor,
                    ),
                  ),
                ),
                // arttırma
                CustomSquareButton(
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: 'Delete'),
                      const SizedBox(width: 5),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: 'Save for later'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See more like this',
                        style: TextStyle(
                          color: activeCyanColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
