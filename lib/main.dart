
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/bloc/habits/habit_bloc.dart';
import 'package:habit_tracker_app/bloc/habits/habit_event.dart';
import 'package:habit_tracker_app/config/theme.dart';
import 'screens/navigation_screen.dart'; // Updated import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitBloc()..add(LoadHabits()),
      child: MaterialApp(
        title: 'Habit Tracker',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const NavigationScreen(), // Updated home widget
      ),
    );
  }
}
