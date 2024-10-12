import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:fashion_flow/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fashion_flow/features/auth/presentation/widgets/auth_option_button.dart';
import 'package:fashion_flow/features/auth/presentation/widgets/divider_text.dart';
import 'package:flutter/material.dart';

class AuthOptionPage extends StatelessWidget {
  static route() => CustomePageRoute(child: const AuthOptionPage());
  const AuthOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Let's you in",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthOptionButton(
              title: 'Continue with Facebook',
              icon: Icons.facebook,
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            AuthOptionButton(
              title: 'Continue with Mail',
              icon: Icons.mail,
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            AuthOptionButton(
              title: 'Continue with Apple',
              icon: Icons.apple,
              onTap: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            const DividerText(
              text: 'or',
            ),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
              title: 'Sign in with password',
              onPress: () {
                Navigator.push(context, SignInPage.route());
              },
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                        context, SignInPage.route(), (route) => false),
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 17,
                      color: Theme.of(context).primaryColorDark),
                  children: const [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
