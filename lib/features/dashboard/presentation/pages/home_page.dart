import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/auth/presentation/pages/auth_option_page.dart';
import 'package:fashion_flow/features/category/presentation/bloc/category_bloc.dart';
import 'package:fashion_flow/features/product/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryFetchAll());
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
              const Text('Product list'),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return buildCategoryShimmer();
            } else if (state is CategorySuccess) {
              return SizedBox(
                height: 110,
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 85,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 42, 76, 68),
                                radius: 29,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget buildCategoryShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of placeholder items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 29,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: 66,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
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
