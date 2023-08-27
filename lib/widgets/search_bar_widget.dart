// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:amazon_clone_app/screens/search_screen.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constants.dart';
import 'package:amazon_clone_app/utils/utils.dart';

class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget({
    super.key,
    required this.isReadOnly,
    required this.hasBackButton,
  }) : preferredSize = const Size.fromHeight(kAppBarHeight);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                )
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SearchScreen();
                      },
                    ));
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search for something...',
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
