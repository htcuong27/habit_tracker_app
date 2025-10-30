
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/pomodoro/pomodoro_bloc.dart';
import '../bloc/pomodoro/pomodoro_state.dart';
import '../bloc/pomodoro/pomodoro_event.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  String _formatDuration(int duration) {
    final minutes = (duration / 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Pomodoro Timer',
          style: GoogleFonts.archivo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<PomodoroBloc, PomodoroState>(
          builder: (context, state) {
            final durationString = _formatDuration(state.duration);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  durationString,
                  style: GoogleFonts.archivo(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.status == PomodoroStatus.initial) ...[
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () => context.read<PomodoroBloc>().add(PomodoroStarted(duration: state.duration)),
                        child: const Icon(Icons.play_arrow),
                      ),
                    ],
                    if (state.status == PomodoroStatus.running) ...[
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () => context.read<PomodoroBloc>().add(PomodoroPaused()),
                        child: const Icon(Icons.pause),
                      ),
                    ],
                    if (state.status == PomodoroStatus.paused) ...[
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () => context.read<PomodoroBloc>().add(PomodoroResumed()),
                        child: const Icon(Icons.play_arrow),
                      ),
                    ],
                    if (state.status == PomodoroStatus.finished) ...[
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () => context.read<PomodoroBloc>().add(PomodoroReset()),
                        child: const Icon(Icons.replay),
                      ),
                    ],
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () => context.read<PomodoroBloc>().add(PomodoroReset()),
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.stop, color: Colors.black87),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
