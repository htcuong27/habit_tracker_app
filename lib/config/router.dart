import 'package:go_router/go_router.dart';
import 'package:habit_tracker_app/screens/account_screen.dart';
import 'package:habit_tracker_app/screens/chat_screen.dart';
import 'package:habit_tracker_app/screens/home_screen.dart';
import 'package:habit_tracker_app/screens/mixer_screen.dart';
import 'package:habit_tracker_app/screens/pomodoro_screen.dart';

class RouteName {
  static const String home = '/';
  static const String login = '/login';
  static const String account = '/account';
  static const String addHabit = '/habit/add/:id';
  static const String mixer = '/mixer';
  static const String pomodoro = '/podomoro';
  static const String chat = '/chat';

  static const publicRoutes = [
    login,
  ];
}

final router = GoRouter(
  redirect: (context, state) {
    if (RouteName.publicRoutes.contains(state.fullPath)) {
      return null;
    }
    // if (context.read<AuthBloc>().state is AuthAuthenticateSuccess) {
    //   return null;
    // }
    return RouteName.home;
  },
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RouteName.mixer,
      builder: (context, state) => MixerScreen(),
    ),
    GoRoute(
      path: RouteName.pomodoro,
      builder: (context, state) => PomodoroScreen(),
    ),
    GoRoute(
      path: RouteName.chat,
      builder: (context, state) => ChatScreen(),
    ),
    GoRoute(
      path: RouteName.account,
      builder: (context, state) => AccountScreen(),
    ),
  ],
);