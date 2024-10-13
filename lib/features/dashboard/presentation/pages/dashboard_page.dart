import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/auth/presentation/pages/auth_option_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatelessWidget {
  static route() => CustomePageRoute(
        child: const DashBoardPage(),
      );
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    AuthLogout(),
                  );
              Navigator.pushAndRemoveUntil(
                  context, AuthOptionPage.route(), (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
