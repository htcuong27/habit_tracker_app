
import 'package:equatable/equatable.dart';
import '../../models/habit.dart';

abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object> get props => [];
}

class HabitsInitial extends HabitState {}

class HabitsLoadInProgress extends HabitState {}

class HabitsLoadSuccess extends HabitState {
  final List<Habit> habits;

  const HabitsLoadSuccess([this.habits = const []]);

  @override
  List<Object> get props => [habits];
}

class HabitsLoadFailure extends HabitState {}
