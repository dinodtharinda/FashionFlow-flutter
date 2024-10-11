import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  static route() => CustomePageRoute(child: const SignInPage());
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Sign In Page'),
      ),
       body: Center(
        child: ElevatedButton(
          child: const Text("Sign in"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, SignUpPage.route(), (e) => false);
          },
        ),
      ),
    );
  }
}
