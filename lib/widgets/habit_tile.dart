
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onCompleted;

  const HabitTile({super.key, required this.habit, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Light gray for secondary elements
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(habit.icon, size: 28, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              habit.name,
              style: GoogleFonts.archivo(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: onCompleted,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: habit.isCompleted ? Colors.black : Colors.white,
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: Icon(
                Icons.check,
                color: habit.isCompleted ? Colors.white : Colors.transparent,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

