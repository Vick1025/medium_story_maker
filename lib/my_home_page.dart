import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:story_maker/feature/landing_navigate/presentation/pages/navigator_page.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/menu_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: ZoomDrawerController(),
      menuScreen: const MenuScreen(),
      mainScreen: const NavigatorPage(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}
