import 'package:fashion_flow/core/common/widgets/product_grid_tile.dart';
import 'package:fashion_flow/features/product/presentation/bloc/product_bloc.dart';
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
              childAspectRatio: 2 / 3.5,
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
              return ProductGridTile(
                product: product,
                onFavoritePress: () {
                  context.read<WishlistBloc>().add(
                        WishlistToggle(product: product),
                      );
                },
              );
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
        childAspectRatio: 2 / 3,
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
