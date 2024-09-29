import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavigaion extends StatelessWidget {
  const BottomNavigaion({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
              label: 'Beranda',
              icon: SvgPicture.asset(
                'assets/home.svg',
                width: 24,
                height: 24,
              )),
          BottomNavigationBarItem(
              label: 'Produk',
              icon: SvgPicture.asset(
                'assets/product.svg',
                width: 24,
                height: 24,
              )),
          BottomNavigationBarItem(
              label: 'Service',
              icon: SvgPicture.asset(
                'assets/service.svg',
                width: 24,
                height: 24,
              )),
          BottomNavigationBarItem(
              label: 'Riwayat',
              icon: SvgPicture.asset(
                'assets/history.svg',
                width: 24,
                height: 24,
              )),
          BottomNavigationBarItem(
              label: 'Akun',
              icon: SvgPicture.asset(
                'assets/account.svg',
                width: 24,
                height: 24,
              )),
        ],
      ),
    );
  }

  /// This method handles events when an item on the [CustomBottomNavigationBar] is tapped.
  ///
  /// [index] is the index of the item tapped on the navigation bar.
  void _onTap(int index) {
    // When navigating to a new branch, it is recommended to use the goBranch method,
    // as this ensures the last navigation state of the Navigator for that branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
