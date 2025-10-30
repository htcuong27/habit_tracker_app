import 'package:equatable/equatable.dart';

abstract class PomodoroEvent extends Equatable {
  const PomodoroEvent();

  @override
  List<Object> get props => [];
}

class PomodoroStarted extends PomodoroEvent {
  final int duration;

  const PomodoroStarted({required this.duration});
}

class PomodoroPaused extends PomodoroEvent {}

class PomodoroResumed extends PomodoroEvent {}

class PomodoroReset extends PomodoroEvent {}

class PomodoroTicked extends PomodoroEvent {
  final int duration;

  const PomodoroTicked({required this.duration});
}