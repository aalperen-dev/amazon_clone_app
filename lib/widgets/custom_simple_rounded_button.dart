// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomSimpleRoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomSimpleRoundedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.5,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
