import 'dart:typed_data';

import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/loading_widget.dart';
import 'package:amazon_clone_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 4;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();

  Expanded spaceTool = Expanded(child: Container());

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? Image.network(
                                      'https://w7.pngwing.com/pngs/205/731/png-transparent-default-avatar-thumbnail.png',
                                      height: screenSize.height / 10,
                                    )
                                  : Image.memory(
                                      image!,
                                      height: screenSize.height / 10,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImage();

                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.file_upload),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            height: screenSize.height * 0.7,
                            width: screenSize.width * 0.7,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ürün adı
                                TextFieldWidget(
                                  title: 'Name',
                                  controller: nameController,
                                  obscureText: false,
                                  hintText: 'Enter the name of the item',
                                ),
                                // ürün fiyatı
                                TextFieldWidget(
                                  title: 'Cost',
                                  controller: costController,
                                  obscureText: false,
                                  hintText: 'Enter the cost of the item',
                                ),
                                const Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                ListTile(
                                  title: const Text('None'),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('70%'),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('60%'),
                                  leading: Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('50%'),
                                  leading: Radio(
                                    value: 4,
                                    groupValue: selected,
                                    onChanged: (value) {
                                      setState(() {
                                        selected = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // sat butonu
                          CustomMainButton(
                            color: yellowColor,
                            isLoading: isLoading,
                            onPressed: () {},
                            child: const Text(
                              'Sell',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          // geri dönüş butonu
                          CustomMainButton(
                            color: Colors.grey,
                            isLoading: false,
                            onPressed: () {},
                            child: const Text(
                              'Sell',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
