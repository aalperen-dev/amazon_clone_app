import 'package:amazon_clone_app/models/user_details_model.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/widgets/banner_ad_widget.dart';
import 'package:amazon_clone_app/widgets/categories_horizontal_list.dart';
import 'package:amazon_clone_app/widgets/products_showcase_list_view.dart';
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:amazon_clone_app/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                const CategoriesHorizontalListViewBar(),
                const BannerAdWidget(),
                ProductsShowcaseListView(
                  title: 'Up to %70 off',
                  children: testChildren,
                ),
                ProductsShowcaseListView(
                  title: 'Up to %60 off',
                  children: testChildren,
                ),
                ProductsShowcaseListView(
                  title: 'Up to %50 off',
                  children: testChildren,
                ),
                ProductsShowcaseListView(
                  title: 'Explore',
                  children: testChildren,
                ),
              ],
            ),
          ),
          UserDetailsBar(
            offset: offset,
            userDetails: UserDetailsModel(
              name: 'Alperen',
              address: 'Somewhere..',
            ),
          ),
        ],
      ),
    );
  }
}
