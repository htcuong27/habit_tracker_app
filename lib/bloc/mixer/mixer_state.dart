
import 'package:equatable/equatable.dart';
import '../../models/sound.dart';

abstract class MixerState extends Equatable {
  const MixerState();

  @override
  List<Object> get props => [];
}

class MixerInitial extends MixerState {}

class MixerLoadInProgress extends MixerState {}

class MixerLoadSuccess extends MixerState {
  final List<Sound> sounds;

  const MixerLoadSuccess([this.sounds = const []]);

  @override
  List<Object> get props => [sounds];
}

class MixerLoadFailure extends MixerState {}
