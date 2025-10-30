
import 'package:flutter/material.dart';

class Sound {
  final String name;
  final IconData icon;
  final String url;
  bool isPlaying;
  double volume;

  Sound({
    required this.name,
    required this.icon,
    required this.url,
    this.isPlaying = false,
    this.volume = 0.5,
  });
}
