
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../models/sound.dart';
import 'mixer_event.dart';
import 'mixer_state.dart';
import 'package:flutter/material.dart';

class MixerBloc extends Bloc<MixerEvent, MixerState> {
  final Map<String, AudioPlayer> _audioPlayers = {};

  MixerBloc() : super(MixerInitial()) {
    on<LoadSounds>(_onLoadSounds);
    on<ToggleSound>(_onToggleSound);
    on<ChangeVolume>(_onChangeVolume);
  }

  @override
  Future<void> close() {
    for (var player in _audioPlayers.values) {
      player.dispose();
    }
    return super.close();
  }

  void _onLoadSounds(LoadSounds event, Emitter<MixerState> emit) {
    emit(MixerLoadInProgress());
    try {
      final sounds = [
        Sound(name: 'Rain', icon: Icons.beach_access, url: 'https://www.soundjay.com/nature/rain-01.mp3'),
        Sound(name: 'Birds', icon: Icons.pets, url: 'https://www.soundjay.com/nature/birds-01.mp3'),
        Sound(name: 'Campfire', icon: Icons.local_fire_department, url: 'https://www.soundjay.com/nature/campfire-1.mp3'),
        Sound(name: 'River', icon: Icons.waves, url: 'https://www.soundjay.com/nature/river-1.mp3'),
      ];
      emit(MixerLoadSuccess(sounds));
    } catch (_) {
      emit(MixerLoadFailure());
    }
  }

  Future<void> _onToggleSound(ToggleSound event, Emitter<MixerState> emit) async {
    if (state is MixerLoadSuccess) {
      final currentState = state as MixerLoadSuccess;
      final sound = event.sound;
      final player = _getOrCreatePlayer(sound.url);

      if (sound.isPlaying) {
        await player.pause();
      } else {
        await player.play();
      }

      final updatedSounds = currentState.sounds.map((s) {
        if (s.name == sound.name) {
          s.isPlaying = !s.isPlaying;
        }
        return s;
      }).toList();

      emit(MixerLoadSuccess(updatedSounds));
    }
  }

  void _onChangeVolume(ChangeVolume event, Emitter<MixerState> emit) {
    if (state is MixerLoadSuccess) {
      final currentState = state as MixerLoadSuccess;
      final sound = event.sound;
      final player = _getOrCreatePlayer(sound.url);

      player.setVolume(event.volume);

      final updatedSounds = currentState.sounds.map((s) {
        if (s.name == sound.name) {
          s.volume = event.volume;
        }
        return s;
      }).toList();

      emit(MixerLoadSuccess(updatedSounds));
    }
  }

  AudioPlayer _getOrCreatePlayer(String url) {
    if (_audioPlayers.containsKey(url)) {
      return _audioPlayers[url]!;
    } else {
      final newPlayer = AudioPlayer();
      newPlayer.setUrl(url);
      newPlayer.setLoopMode(LoopMode.one);
      _audioPlayers[url] = newPlayer;
      return newPlayer;
    }
  }
}
