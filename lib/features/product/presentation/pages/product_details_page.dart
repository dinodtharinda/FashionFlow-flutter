import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/core/common/cubits/favorite_icon_button/favorite_icon_button_cubit.dart';
import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/core/common/widgets/network_image.dart';
import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  static route(Product product) => CustomePageRoute(
        child: ProductDetailsPage(
          product: product,
        ),
      );

  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey.withOpacity(0.05),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total price',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                      color: Colors.grey),
                ),
                Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: Flexible(
                child: PrimaryButton(
                  title: 'Add to Cart',
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.15),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.grey.withOpacity(0.15),
                child: Column(
                  children: [
                    CarouselSlider(
                      items: widget.product.images
                          .map((image) => ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CustomNetworkImage(
                                  imageUrl: image,
                                  loading: true,
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.product.images.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _currentIndex = entry.key;
                          }),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        BlocProvider(
                          create: (context) => FavoriteIconButtonCubit()
                            ..isFavorite(widget.product.id),
                          child: BlocBuilder<FavoriteIconButtonCubit, bool>(
                            builder: (context, state) {
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .primaryColorDark
                                        .withOpacity(0.3)),
                                child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteIconButtonCubit>()
                                        .onTap(widget.product);
                                  },
                                  icon: Icon(
                                    state
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'stock ${widget.product.stock}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.star,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.product.rating} (${widget.product.reviews.length} reviews)',
                          style: const TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          letterSpacing: 1.2, height: 1.7, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Return Policy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.returnPolicy,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          letterSpacing: 1.2, height: 1.7, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Warranty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.warrantyInformation,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          letterSpacing: 1.2, height: 1.7, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Warranty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.warrantyInformation,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          letterSpacing: 1.2, height: 1.7, fontSize: 15),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
