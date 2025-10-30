import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/habit.dart';
import 'package:flutter/material.dart';

import 'habit_event.dart';
import 'habit_state.dart';

import 'package:flutter/foundation.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc() : super(HabitsInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<ToggleHabitCompletion>(_onToggleHabitCompletion);
    on<AddHabit>(_onAddHabit);
  }

  void _onLoadHabits(LoadHabits event, Emitter<HabitState> emit) {
    emit(HabitsLoadInProgress());
    try {
      // In a real app, you would load this from a repository or database
      final habits = [
        Habit(id: '1', name: 'Morning Run', icon: Icons.directions_run, color: Colors.blue),
        Habit(id: '2', name: 'Read 30 Pages', icon: Icons.book_outlined, color: Colors.orange),
        Habit(id: '3', name: 'Meditate', icon: Icons.self_improvement_outlined, color: Colors.purple),
        Habit(id: '4', name: 'Drink 8 Glasses of Water', icon: Icons.local_drink_outlined, color: Colors.teal),
      ];
      emit(HabitsLoadSuccess(habits));
    } catch (_) {
      emit(HabitsLoadFailure());
    }
  }

  void _onToggleHabitCompletion(ToggleHabitCompletion event, Emitter<HabitState> emit) {
    if (state is HabitsLoadSuccess) {
      final currentState = state as HabitsLoadSuccess;
      final List<Habit> updatedHabits = List.from(currentState.habits);
      final habitIndex = updatedHabits.indexWhere((h) => h.id == event.habit.id);

      if (habitIndex != -1) {
        final habit = updatedHabits[habitIndex];
        updatedHabits[habitIndex] = habit.copyWith(isCompleted: !habit.isCompleted);
        emit(HabitsLoadSuccess(updatedHabits));
      }
    }
  }

  void _onAddHabit(AddHabit event, Emitter<HabitState> emit) {
    if (state is HabitsLoadSuccess) {
      final currentState = state as HabitsLoadSuccess;
      final List<Habit> updatedHabits = List.from(currentState.habits)..add(event.habit);
      emit(HabitsLoadSuccess(updatedHabits));
    }
  }
}