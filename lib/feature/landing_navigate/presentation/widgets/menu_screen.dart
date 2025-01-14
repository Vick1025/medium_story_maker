import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:story_maker/feature/landing_navigate/presentation/blocs/menu_bloc.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/menu_list_item.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/user_email_display.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/user_image_avatar.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/user_name_display.dart';
import 'package:story_maker/feature/setting/presentation/blocs/settings_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _onMenuItemTap(BuildContext context, String titleKey) {
    context.read<MenuBloc>().add(MenuItemSelectedEvent(titleKey.tr()));
    ZoomDrawer.of(context)!.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is MenuScreenState) {}
      },
      builder: (context, state) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserImageAvatar(),
                            SizedBox(height: 16),
                            UserNameDisplay(),
                            SizedBox(height: 8),
                            UserEmailDisplay(),
                          ]),
                    ),
                    const Divider(),
                    MenuListItem(
                      icon: Icons.home,
                      titleKey: 'home',
                      onTap: () => _onMenuItemTap(context, 'home'),
                    ),
                    MenuListItem(
                      icon: Icons.settings,
                      titleKey: 'settings',
                      onTap: () => _onMenuItemTap(context, 'settings'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
