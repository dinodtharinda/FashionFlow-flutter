import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/core/common/widgets/loader.dart';
import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:fashion_flow/core/constants/images.dart';
import 'package:fashion_flow/core/utils/show_snackbar_message.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fashion_flow/features/auth/presentation/widgets/auth_field.dart';
import 'package:fashion_flow/features/auth/presentation/widgets/auth_option_button.dart';
import 'package:fashion_flow/features/auth/presentation/widgets/divider_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => CustomePageRoute(child: const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboadOn = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      // appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBarMsg(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoding) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.logo,
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: 'Email',
                    controller: _emailController,
                    icon: Icons.mail,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: 'Password',
                    controller: _passwordController,
                    icon: Icons.password,
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    title: 'Sign up',
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (!isKeyboadOn)
                    Column(
                      children: [
                        const DividerText(text: 'or continue with'),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthOptionButton(
                          title: 'Continue with Mail',
                          icon: Icons.mail,
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context, SignInPage.route(), (route) => false),
                          child: RichText(
                            text: TextSpan(
                              text: 'have an account? ',
                              style: TextStyle(
                                  letterSpacing: 1.2,
                                  fontSize: 17,
                                  color: Theme.of(context).primaryColorDark),
                              children: const [
                                TextSpan(
                                  text: 'Sign in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
