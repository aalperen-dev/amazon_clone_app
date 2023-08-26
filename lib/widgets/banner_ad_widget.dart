import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constans.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:flutter/material.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double smallAddDimension = screenSize.width / 5;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == (largeAds.length) - 1) {
          currentAd = -1;
        }

        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          // reklam resmi
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  largeAds[currentAd],
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height / 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAddDimension,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsFromIndex(index: 0, side: smallAddDimension),
                getSmallAdsFromIndex(index: 1, side: smallAddDimension),
                getSmallAdsFromIndex(index: 2, side: smallAddDimension),
                getSmallAdsFromIndex(index: 3, side: smallAddDimension),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSmallAdsFromIndex({required index, required double side}) {
    return Container(
      height: side,
      width: side,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                smallAds[index],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  adItemNames[index],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
