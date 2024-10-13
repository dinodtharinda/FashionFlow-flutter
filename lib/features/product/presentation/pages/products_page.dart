import 'package:fashion_flow/features/product/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final searchController = TextEditingController();

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
        padding: const EdgeInsets.only(top: 10),
        color: Theme.of(context).primaryColorDark.withOpacity(0.05),
        child: SizedBox(
          height: 110,
          child: Scrollbar(
            child: ListView(
              scrollDirection: Axis.horizontal,
              primary: false,
              children: List.generate(
                14,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: 85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.tealAccent,
                          radius: 29,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
