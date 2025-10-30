import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'pomodoro_event.dart';
import 'pomodoro_state.dart';

class PomodoroBloc extends Bloc<PomodoroEvent, PomodoroState> {
  static const int _defaultDuration = 25 * 60; // 25 minutes
  StreamSubscription<int>? _tickerSubscription;

  PomodoroBloc() : super(const PomodoroInitial(_defaultDuration)) {
    on<PomodoroStarted>(_onStarted);
    on<PomodoroPaused>(_onPaused);
    on<PomodoroResumed>(_onResumed);
    on<PomodoroReset>(_onReset);
    on<PomodoroTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(PomodoroStarted event, Emitter<PomodoroState> emit) {
    emit(PomodoroRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = Stream.periodic(const Duration(seconds: 1), (x) => event.duration - x - 1)
        .take(event.duration)
        .listen((duration) => add(PomodoroTicked(duration: duration)));
  }

  void _onPaused(PomodoroPaused event, Emitter<PomodoroState> emit) {
    if (state is PomodoroRunInProgress) {
      _tickerSubscription?.pause();
      emit(PomodoroRunPause(state.duration));
    }
  }

  void _onResumed(PomodoroResumed event, Emitter<PomodoroState> emit) {
    if (state is PomodoroRunPause) {
      _tickerSubscription?.resume();
      emit(PomodoroRunInProgress(state.duration));
    }
  }

  void _onReset(PomodoroReset event, Emitter<PomodoroState> emit) {
    _tickerSubscription?.cancel();
    emit(const PomodoroInitial(_defaultDuration));
  }

  void _onTicked(PomodoroTicked event, Emitter<PomodoroState> emit) {
    if (event.duration > 0) {
      emit(PomodoroRunInProgress(event.duration));
    } else {
      emit(const PomodoroRunComplete());
    }
  }
}