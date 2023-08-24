import 'package:amazon_clone_app/resources/authentication_methods.dart';
import 'package:amazon_clone_app/screens/sign_up_screen.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:amazon_clone_app/utils/constans.dart';
import 'package:amazon_clone_app/utils/utils.dart';
import 'package:amazon_clone_app/widgets/custom_main_button.dart';
import 'package:amazon_clone_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
                  Container(
                    padding: const EdgeInsets.all(25),
                    height: screenSize.height * 0.6,
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
                          'Sign-in',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                          ),
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
                            isLoading: isLoading,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              String output = await AuthMethods().signInUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                              setState(() {
                                isLoading = false;
                              });
                              if (output == 'success') {
                                // giriş yapılacak
                                AuthMethods().signInUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              } else {
                                // hata
                                Utils().showSnakBar(
                                    context: context, content: output);
                              }
                            },
                            child: const Text(
                              'Sign-In',
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          'New to Amazon?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignupScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Create an Account',
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
