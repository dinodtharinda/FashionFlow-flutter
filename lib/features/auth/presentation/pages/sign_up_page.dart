import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  static route() => CustomePageRoute(child: const SignUpPage());
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Sign in"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, SignInPage.route(), (e) => false);
          },
        ),
      ),
    );
  }
}
