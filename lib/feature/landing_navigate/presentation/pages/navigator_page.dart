import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_maker/feature/landing_navigate/presentation/blocs/menu_bloc.dart';
import 'package:story_maker/feature/landing_navigate/presentation/pages/f05_main_screen.dart';
import 'package:story_maker/feature/setting/presentation/pages/f10_settings_screen.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(builder: (context, state) {
      if (state is MenuScreenState) {
        return _getScreen(state.selectedItem);
      }
      return const F05MainScreen();
    });
  }

  Widget _getScreen(String menuItem) {
    if (menuItem == 'settings'.tr()) {
      return const F10SettingsScreen();
    } else if (menuItem == 'home'.tr()) {
      return const F05MainScreen();
    } else {
      return const F05MainScreen();
    }
  }
}
