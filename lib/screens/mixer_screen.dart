
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/mixer/mixer_bloc.dart';
import '../bloc/mixer/mixer_state.dart';
import '../bloc/mixer/mixer_event.dart';
import '../models/sound.dart';

class MixerScreen extends StatelessWidget {
  const MixerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'White Noise Mixer',
          style: GoogleFonts.archivo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<MixerBloc, MixerState>(
        builder: (context, state) {
          if (state is MixerLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MixerLoadSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: state.sounds.length,
              itemBuilder: (context, index) {
                final sound = state.sounds[index];
                return _SoundControl(sound: sound);
              },
            );
          } else if (state is MixerLoadFailure) {
            return const Center(child: Text('Failed to load sounds.'));
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
    );
  }
}

class _SoundControl extends StatelessWidget {
  final Sound sound;

  const _SoundControl({required this.sound});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(sound.icon, size: 40),
          const SizedBox(height: 8),
          Text(
            sound.name,
            style: GoogleFonts.archivo(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Switch(
            value: sound.isPlaying,
            onChanged: (_) {
              context.read<MixerBloc>().add(ToggleSound(sound));
            },
            activeColor: Colors.black,
          ),
          Slider(
            value: sound.volume,
            onChanged: (volume) {
              context.read<MixerBloc>().add(ChangeVolume(sound, volume));
            },
            min: 0.0,
            max: 1.0,
            activeColor: Colors.black,
            inactiveColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}
