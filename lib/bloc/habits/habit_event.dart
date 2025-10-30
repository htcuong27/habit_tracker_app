import 'package:equatable/equatable.dart';
import '../../models/habit.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class LoadHabits extends HabitEvent {}

class ToggleHabitCompletion extends HabitEvent {
  final Habit habit;

  const ToggleHabitCompletion(this.habit);

  @override
  List<Object> get props => [habit];
}

class AddHabit extends HabitEvent {
  final Habit habit;

  const AddHabit(this.habit);

  @override
  List<Object> get props => [habit];
}