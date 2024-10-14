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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, state) {
            if (state is WishlistFailure) {
              showSnackBarMsg(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Loader();
            } else if (state is WishlistDisplaySuccess) {
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
                itemCount: state.wishlist.length,
                itemBuilder: (context, index) {
                  final wishlist = state.wishlist[index];
                  return ProductGridTile(
                    product: wishlist.product,
                    onFavoritePress: () {
                      context.read<WishlistBloc>().add(
                            WishlistToggle(product: wishlist.product),
                          );
                    },
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
