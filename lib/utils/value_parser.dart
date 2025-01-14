import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:story_maker/core/shared/constants.dart';

/// Get the language name from the locale.
String getLanguageName(Locale locale) {
  switch (locale.languageCode) {
    case kTradionnalChineseLanguageCode:
      return 'traditional_chinese'.tr();
    case kEnglishLanguageCode:
      return 'english'.tr();
    case kJapaneseLanguageCode:
      return 'japanese'.tr();
    default:
      return 'unknown'.tr();
  }
}

/// Parse the locale from the saved locale.
Locale parseLocale(String? savedLocale) {
  if (savedLocale == null) {
    return const Locale(kEnglishLanguageCode);
  }

  final parts = savedLocale.split('_');
  if (parts.length > 1) {
    return Locale(parts[0], parts[1]);
  } else {
    return Locale(parts[0]);
  }
}
