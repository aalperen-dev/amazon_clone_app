import 'package:amazon_clone_app/utils/constans.dart';
import 'package:amazon_clone_app/widgets/banner_ad_widget.dart';
import 'package:amazon_clone_app/widgets/categories_horizontal_list.dart';
import 'package:amazon_clone_app/widgets/products_showcase_list_view.dart';
import 'package:amazon_clone_app/widgets/search_bar_widget.dart';
import 'package:amazon_clone_app/widgets/simple_product_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> testChildren = [
    SimpleProductWidget(url: largeAds[0]),
    SimpleProductWidget(url: categoryLogos[0]),
    SimpleProductWidget(url: largeAds[0]),
    SimpleProductWidget(url: categoryLogos[0]),
    SimpleProductWidget(url: largeAds[0]),
    SimpleProductWidget(url: categoryLogos[0]),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoriesHorizontalListViewBar(),
            BannerAdWidget(),
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
    );
  }
}
