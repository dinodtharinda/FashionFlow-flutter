import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/auth/presentation/pages/auth_option_page.dart';
import 'package:fashion_flow/features/category/presentation/widgets/category_list_widget.dart';
import 'package:fashion_flow/features/product/presentation/widgets/product_grid_widget.dart';
import 'package:fashion_flow/features/product/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SearchField(
                hintText: 'Search',
                icon: Icons.search,
                controller: searchController,
              ),
              const SizedBox(
                height: 30,
              ),
              const SpecialOffersWidget(),
              const SizedBox(
                height: 20,
              ),
              const CategoryListWidget(),
              const SizedBox(
                height: 20,
              ),
              const ProductGridWidget(),
              const SizedBox(
                height: 30,
              ),
              PrimaryButton(
                  title: 'logout',
                  onPress: () {
                    context.read<AuthBloc>().add(AuthLogout());
                    Navigator.pushAndRemoveUntil(
                      context,
                      AuthOptionPage.route(),
                      (route) => false,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}



class SpecialOffersWidget extends StatelessWidget {
  const SpecialOffersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Special Offers',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
          ),
          height: 200,
        )
      ],
    );
  }
}
