part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class InitializeSettingsEvent extends SettingsEvent {}

class ChangeLanguageEvent extends SettingsEvent {
  final Locale locale;
  ChangeLanguageEvent(this.locale);
}

class ChangeThemeModeEvent extends SettingsEvent {
  final ThemeModeEnum themeModeEnum;
  ChangeThemeModeEvent(this.themeModeEnum);
}
