import 'package:flutter/material.dart';

import '../utils/color_themes.dart';
import '../utils/constans.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        height: screenSize.height * 0.85,
                        width: screenSize.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign-Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 32,
                              ),
                            ),
                            TextFieldWidget(
                              hintText: 'Enter your name',
                              title: 'Name',
                              controller: nameController,
                              obscureText: false,
                            ),
                            TextFieldWidget(
                              hintText: 'Enter your adress',
                              title: 'Adress',
                              controller: addressController,
                              obscureText: false,
                            ),
                            TextFieldWidget(
                              hintText: 'Enter your e-mail',
                              title: 'E-mail',
                              controller: emailController,
                              obscureText: false,
                            ),
                            TextFieldWidget(
                              hintText: 'Enter your password',
                              title: 'Password',
                              controller: passwordController,
                              obscureText: true,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                color: yellowColor,
                                isLoading: false,
                                onPressed: () {},
                                child: const Text(
                                  'Sign-Up',
                                  style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
