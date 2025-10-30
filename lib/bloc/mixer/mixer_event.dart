
import 'package:equatable/equatable.dart';

import '../../models/sound.dart';

abstract class MixerEvent extends Equatable {
  const MixerEvent();

  @override
  List<Object> get props => [];
}

class LoadSounds extends MixerEvent {}

class ToggleSound extends MixerEvent {
  final Sound sound;

  const ToggleSound(this.sound);

  @override
  List<Object> get props => [sound];
}

class ChangeVolume extends MixerEvent {
  final Sound sound;
  final double volume;

  const ChangeVolume(this.sound, this.volume);

  @override
  List<Object> get props => [sound, volume];
}
