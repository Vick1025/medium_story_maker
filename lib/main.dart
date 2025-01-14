import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_maker/core/dependencies_injection.dart';
import 'package:story_maker/core/enums/settings_enum.dart';
import 'package:story_maker/core/router/router_config.dart';
import 'package:story_maker/core/shared/blocs/user_info/user_info_bloc.dart';
import 'package:story_maker/core/shared/constants.dart';
import 'package:story_maker/core/theme/app_theme.dart';
import 'package:story_maker/feature/landing_navigate/presentation/blocs/menu_bloc.dart';
import 'package:story_maker/feature/setting/presentation/blocs/settings_bloc.dart';
import 'package:story_maker/pico_voice/story_maker_pico_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await setupDependencies();
  await dotenv.load(fileName: ".env");

  _initPicoClient();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(kTradionnalChineseLanguageCode, kTradionnalChineseCountryCode),
        Locale(kEnglishLanguageCode),
        Locale(kJapaneseLanguageCode)
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale(kEnglishLanguageCode),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsBloc()),
          BlocProvider(create: (context) => MenuBloc()),
          BlocProvider(create: (context) => UserInfoBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

/// Init the pico voice client
Future<void> _initPicoClient() async {
  final picoClient = StoryMakerPicoClient();

  await picoClient.initRhino(
    accessKey: dotenv.env['PICO_VOICE_ACCESS_KEY'] ?? '',
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsScreenState) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, dynamic result) {
              _onPopInvoked(context, didPop);
            },
            child: MaterialApp.router(
              title: 'app_title'.tr(),
              routerConfig: appRouter,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: state.locale,
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: state.themeModeEnum == ThemeModeEnum.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
              debugShowCheckedModeBanner: false,
            ),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void _onPopInvoked(BuildContext context, bool didPop) async {
    if (didPop) return; // If already handled pop, we don't need to do anything
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('press_back_again_to_exit_app'.tr()),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      await SystemNavigator.pop();
    }
  }
}
