import 'package:fashion_flow/core/common/cubits/display_wishlist/display_wishlist_cubit.dart';
import 'package:fashion_flow/core/common/cubits/favorite_icon_button/favorite_icon_button_cubit.dart';
import 'package:fashion_flow/core/common/widgets/loader.dart';
import 'package:fashion_flow/core/common/widgets/product_grid_tile.dart';
import 'package:fashion_flow/core/utils/show_snackbar_message.dart';
import 'package:fashion_flow/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    context.read<WishlistBloc>().add(WishlistFetchAll());
    super.initState();
  }

  SliverGridDelegate gridDelegate =
      const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 2 / 3.5,
    crossAxisSpacing: 15,
    crossAxisCount: 2,
    mainAxisSpacing: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<DisplayWishlistCubit, DisplayWishlistState>(
          listener: (context, state) {
            if (state is DisplayWishlistFailure) {
              showSnackBarMsg(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is DisplayWishlistLoading) {
              return const Loader();
            } else if (state is DisplayWishlistSuccess) {
              return GridView.builder(
                gridDelegate: gridDelegate,
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                itemCount: state.wishlist.length,
                itemBuilder: (context, index) {
                  final wishlist = state.wishlist[index];
                  return BlocProvider(
                    create: (context) =>
                        FavoriteIconButtonCubit()..isFavorite(wishlist.id),
                    child: BlocBuilder<FavoriteIconButtonCubit, bool>(
                      builder: (context, state) {
                        return ProductGridTile(
                          product: wishlist.product,
                          onFavoritePress: () {
                            context
                                .read<FavoriteIconButtonCubit>()
                                .onTap(wishlist.product);
                            setState(() {});
                          },
                          isFavotire: true,
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
