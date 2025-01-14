import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_maker/core/shared/constants.dart';
import 'package:story_maker/feature/setting/presentation/blocs/settings_bloc.dart';

class LanguageDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('choose_language'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('traditional_chinese'.tr()),
                onTap: () => _changeLanguage(
                  context,
                  const Locale(kTradionnalChineseLanguageCode,
                      kTradionnalChineseCountryCode),
                ),
              ),
              ListTile(
                title: Text('english'.tr()),
                onTap: () => _changeLanguage(
                  context,
                  const Locale(kEnglishLanguageCode),
                ),
              ),
              ListTile(
                title: Text('japanese'.tr()),
                onTap: () => _changeLanguage(
                  context,
                  const Locale(kJapaneseLanguageCode),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void _changeLanguage(BuildContext context, Locale newLocale) {
    context.read<SettingsBloc>().add(ChangeLanguageEvent(newLocale));
    context.setLocale(newLocale);
    Navigator.of(context).pop();
  }
}
