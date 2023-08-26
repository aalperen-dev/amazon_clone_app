import 'package:amazon_clone_app/layout/screen_layout.dart';
import 'package:amazon_clone_app/screens/sign_in_screen.dart';
import 'package:amazon_clone_app/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBdzb42PyCSuIj6K5i78UW9QdSm5Ff14XE",
          authDomain: "clone-3270b.firebaseapp.com",
          projectId: "clone-3270b",
          storageBucket: "clone-3270b.appspot.com",
          messagingSenderId: "1090340919443",
          appId: "1:1090340919443:web:3fcbe60ce682bc2cd7d566"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazone Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          } else if (user.hasData) {
            return const ScreenLayout();
          } else {
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
