import 'package:fashion_flow/core/common/widgets/loader.dart';
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
      body: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state is WishlistFailure) {
            showSnackBarMsg(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Loader();
          } else if (state is WishlistDisplaySuccess) {
            return Center(child:  Text('success ${state.wishlist.length}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
