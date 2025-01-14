import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_maker/core/enums/settings_enum.dart';
import 'package:story_maker/core/shared/constants.dart';
import 'package:story_maker/utils/value_parser.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _localeKey = 'locale';
  static const String _themeModeKey = 'themeMode';

  SettingsBloc()
      : super(SettingsScreenState(
          locale: const Locale(kEnglishLanguageCode),
          themeModeEnum: ThemeModeEnum.light,
        )) {
    on<InitializeSettingsEvent>(_onInitializeSettings);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ChangeThemeModeEvent>(_onChangeThemeMode);

    add(InitializeSettingsEvent());
  }

  /// When the app is initialized, we need to load the saved settings from the shared preferences. Then we can display the right language and theme mode.
  Future<void> _onInitializeSettings(
      InitializeSettingsEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString(_localeKey);
    final int? savedThemeMode = prefs.getInt(_themeModeKey);

    final Locale locale = parseLocale(savedLocale);
    final ThemeModeEnum themeMode = ThemeModeEnum.values[savedThemeMode ?? 0];

    emit(SettingsScreenState(locale: locale, themeModeEnum: themeMode));
  }

  /// When the user changes the language, we need to save the new language to the shared preferences.
  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, event.locale.languageCode);

    emit(SettingsScreenState(
      locale: event.locale,
      themeModeEnum: (state as SettingsScreenState).themeModeEnum,
    ));
  }

  /// When the user changes the theme mode, we need to save the new theme mode to the shared preferences.
  Future<void> _onChangeThemeMode(
      ChangeThemeModeEvent event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, event.themeModeEnum.index);

    emit(SettingsScreenState(
      locale: (state as SettingsScreenState).locale,
      themeModeEnum: event.themeModeEnum,
    ));
  }
}
