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
      body: Padding(
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
                      'Sign-ın',
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
                        color: Colors.orange,
                        isLoading: false,
                        onPressed: () {},
                        child: const Text(
                          'Sign-In',
                          style: TextStyle(
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomMainButton(
                color: Colors.grey[400]!,
                isLoading: false,
                onPressed: () {},
                child: Text(
                  'Create an Amazon Account',
                  style: TextStyle(letterSpacing: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
