import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/features/dashboard/presentation/pages/home_page.dart';
import 'package:fashion_flow/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  static route() => CustomePageRoute(
        child: const DashBoardPage(),
      );
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Text("store"),
    const WishlistPage(),
    const Text("settings"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: _pageIndex,
        onDestinationSelected: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'home'),
          NavigationDestination(
              icon: Icon(Icons.storefront_sharp), label: 'Store'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          NavigationDestination(
              icon: Icon(Icons.settings_outlined), label: 'settings'),
        ],
      ),
      body: Center(child: _pages[_pageIndex]),
    );
  }
}
