import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/account_screen_app_bar.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/products_showcase_list_view.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              const IntroductionWidgetAccountScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {},
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                  color: yellowColor,
                  isLoading: false,
                  onPressed: () {},
                  child: const Text(
                    'Sell',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ProductsShowcaseListView(
                title: 'Your Orders',
                children: testChildren,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Requests',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: const Text(
                        'Order: Black Shoe',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text('Address: Somewhere....'),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.00000000001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 27,
                      ),
                    ),
                    TextSpan(
                      text: 'Alperen',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://m.media-amazon.com/images/M/MV5BOTNmZGU0MDYtNDE4Zi00NTE4LTg0ZGEtYzBjOWNjOTkwMzdlXkEyXkFqcGdeQXVyMTg3Nzg5ODY@._V1_.jpg'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
