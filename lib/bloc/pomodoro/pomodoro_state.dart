import 'package:equatable/equatable.dart';

enum PomodoroStatus { initial, running, paused, finished }

abstract class PomodoroState extends Equatable {
  final int duration;
  final PomodoroStatus status;

  const PomodoroState(this.duration, this.status);

  @override
  List<Object> get props => [duration, status];
}

class PomodoroInitial extends PomodoroState {
  const PomodoroInitial(int duration) : super(duration, PomodoroStatus.initial);
}

class PomodoroRunInProgress extends PomodoroState {
  const PomodoroRunInProgress(int duration) : super(duration, PomodoroStatus.running);
}

class PomodoroRunPause extends PomodoroState {
  const PomodoroRunPause(int duration) : super(duration, PomodoroStatus.paused);
}

class PomodoroRunComplete extends PomodoroState {
  const PomodoroRunComplete() : super(0, PomodoroStatus.finished);
}