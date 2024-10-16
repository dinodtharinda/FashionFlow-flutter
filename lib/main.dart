import 'package:fashion_flow/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_categories/display_categories_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_products/display_products_cubit.dart';
import 'package:fashion_flow/core/common/cubits/display_wishlist/display_wishlist_cubit.dart';
import 'package:fashion_flow/core/themes/theme.dart';
import 'package:fashion_flow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fashion_flow/features/auth/presentation/pages/auth_option_page.dart';
import 'package:fashion_flow/features/category/presentation/bloc/category_bloc.dart';
import 'package:fashion_flow/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:fashion_flow/features/product/presentation/bloc/product_bloc.dart';
import 'package:fashion_flow/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:fashion_flow/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<CategoryBloc>()),
        BlocProvider(create: (_) => serviceLocator<DisplayCatogoriesCubit>()),
        BlocProvider(create: (_) => serviceLocator<ProductBloc>()),
        BlocProvider(create: (_) => serviceLocator<DisplayProductsCubit>()),
        BlocProvider(create: (_) => serviceLocator<WishlistBloc>()),
        BlocProvider(create: (_) => serviceLocator<DisplayWishlistCubit>()),

      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetCurrentUser());
    context.read<CategoryBloc>().add(CategoryFetchAll());
    context.read<ProductBloc>().add(ProductFetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const DashBoardPage();
          } else {
            return const AuthOptionPage();
          }
        },
      ),
    );
  }
}
