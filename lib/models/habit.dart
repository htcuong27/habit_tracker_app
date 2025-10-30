
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Habit extends Equatable {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final bool isCompleted;

  const Habit({
    required this.id,
    required this.name,
    required this.icon,
    this.color = Colors.grey,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, name, icon, color, isCompleted];

  Habit copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    bool? isCompleted,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
