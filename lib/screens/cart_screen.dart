import 'package:amazon_clone_app/models/product_model.dart';
import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/widgets/cart_item_widget.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:amazon_clone_app/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

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
                  child: CustomMainButton(
                    color: yellowColor,
                    isLoading: false,
                    onPressed: () {},
                    child: const Text(
                      'Proceed to buy x items',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        product: ProductModel(
                            imgUrl: amazonLogoUrl,
                            productName: 'rick',
                            cost: 9.999,
                            discount: 0,
                            uid: 'asddda',
                            sellerName: 'rick seller',
                            sellerUid: 'aasssdda',
                            rating: 1,
                            noOfRating: 1),
                      );
                    },
                  ),
                )
              ],
            ),
            UserDetailsBar(
              offset: 0,
              // userDetails: UserDetailsModel(name: 'alp', address: 'test'),
            ),
          ],
        ),
      ),
    );
  }
}
