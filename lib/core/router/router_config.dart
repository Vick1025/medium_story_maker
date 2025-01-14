import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_maker/feature/draft_keeper/presentation/pages/f20_draft_list_page.dart';
import 'package:story_maker/my_home_page.dart';

///The top layer pages just use side menu to navigate, don't need to set in router.
///For example: F05MainScreen, F10SettingsScreen,

const basicTransitionDuration = Duration(milliseconds: 500);

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MaterialPage<void>(
        key: state.pageKey,
        child: const MyHomePage(),
      ),
    ),
    GoRoute(
      path: '/F20',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CustomTransitionPage<void>(
        key: state.pageKey,
        child: const F20DraftListPage(),
        transitionDuration: basicTransitionDuration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
  ],
);
