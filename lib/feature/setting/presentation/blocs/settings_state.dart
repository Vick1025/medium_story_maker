part of 'settings_bloc.dart';

sealed class SettingsState {
  const SettingsState();
}

class SettingsScreenState extends SettingsState {
  final Locale locale;
  final ThemeModeEnum themeModeEnum;

  SettingsScreenState({
    required this.locale,
    required this.themeModeEnum,
  });
}
