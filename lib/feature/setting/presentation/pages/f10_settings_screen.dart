import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:story_maker/core/enums/settings_enum.dart';
import 'package:story_maker/feature/setting/presentation/blocs/settings_bloc.dart';
import 'package:story_maker/feature/setting/presentation/widgets/setting_list_item.dart';
import 'package:story_maker/utils/value_parser.dart';
import 'package:story_maker/utils/widgets/language_dialog.dart';
import 'package:story_maker/utils/widgets/menu_button.dart';

class F10SettingsScreen extends StatelessWidget {
  const F10SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (settingContext, state) {
        if (state is SettingsScreenState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('settings'.tr()),
              centerTitle: true,
              leading: const MenuButton(),
            ),
            body: ListView(
              children: [
                SettingListItem(
                  title: 'language'.tr(),
                  subtitle: getLanguageName(state.locale),
                  onTap: () => LanguageDialog.show(settingContext),
                ),
                SettingListItem(
                  title: 'theme'.tr(),
                  //Add AbsorbPointer to make UX better
                  trailing: AbsorbPointer(
                    absorbing: true,
                    child: Switch(
                      value: state.themeModeEnum == ThemeModeEnum.dark,
                      onChanged: (value) {},
                    ),
                  ),
                  onTap: () => _onThemeToggle(settingContext, state),
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void _onThemeToggle(BuildContext context, SettingsScreenState state) {
    context.read<SettingsBloc>().add(
          ChangeThemeModeEvent(
            state.themeModeEnum == ThemeModeEnum.light
                ? ThemeModeEnum.dark
                : ThemeModeEnum.light,
          ),
        );
  }
}
