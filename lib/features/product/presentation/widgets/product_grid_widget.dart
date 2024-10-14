import 'package:fashion_flow/core/common/entities/product.dart';
import 'package:fashion_flow/features/product/presentation/bloc/product_bloc.dart';
import 'package:fashion_flow/features/product/presentation/widgets/network_image.dart';
import 'package:fashion_flow/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridWidget extends StatefulWidget {
  const ProductGridWidget({
    super.key,
  });

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return _buildShimmerEffect();
        } else if (state is ProductSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 2.8,
              crossAxisSpacing: 15,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
            ),
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductGridTile(product: product);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildShimmerEffect() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2 / 2.8,
        crossAxisSpacing: 15,
        crossAxisCount: 2,
        mainAxisSpacing: 15,
      ),
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemCount: 6, // Adjust the count as per your preference
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Container(
                height: 15,
                width: 40,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductGridTile extends StatefulWidget {
  const ProductGridTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductGridTile> createState() => _ProductGridTileState();
}

class _ProductGridTileState extends State<ProductGridTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.05),
                  child: CustomNetworkImage(
                    imageUrl: widget.product.images.first,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 15,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            widget.product.rating.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text('|'),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Stock ${widget.product.stock}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${widget.product.price}",
                        style: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            onPressed: () {
              context.read<WishlistBloc>().add(
                    WishlistToggle(product: widget.product),
                  );
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        )
      ],
    );
  }
}
