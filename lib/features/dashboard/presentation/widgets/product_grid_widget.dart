import 'package:fashion_flow/core/common/cubits/display_products/display_products_cubit.dart';
import 'package:fashion_flow/core/common/cubits/favorite_icon_button/favorite_icon_button_cubit.dart';
import 'package:fashion_flow/core/common/widgets/product_grid_tile.dart';
import 'package:fashion_flow/features/product/presentation/pages/product_details_page.dart';
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
  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 2 / 3.5,
    crossAxisSpacing: 15,
    crossAxisCount: 2,
    mainAxisSpacing: 15,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayProductsCubit, DisplayProductsState>(
      builder: (context, state) {
        if (state is DisplayProductsLoading ||
            state is DisplayProductsFailure) {
          return _buildShimmerEffect();
        } else if (state is DisplayProductsSuccess) {
          return GridView.builder(
            gridDelegate: gridDelegate,
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return BlocProvider(
                create: (context) =>
                    FavoriteIconButtonCubit()..isFavorite(product.id),
                child: BlocBuilder<FavoriteIconButtonCubit, bool>(
                  builder: (context, state) {
                    return ProductGridTile(
                      onPress: () {
                        Navigator.push(
                          context,
                          ProductDetailsPage.route(product),
                        );
                      },
                      isFavotire: state,
                      product: product,
                      onFavoritePress: () {
                        context.read<FavoriteIconButtonCubit>().onTap(product);
                      },
                    );
                  },
                ),
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
      gridDelegate: gridDelegate,
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
