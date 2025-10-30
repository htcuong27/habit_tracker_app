import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/bloc/habits/habit_bloc.dart';
import 'package:habit_tracker_app/bloc/habits/habit_event.dart';
import 'package:habit_tracker_app/models/habit.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _nameController = TextEditingController();
  Color _selectedColor = const Color(0xFF76D7C4);
  IconData _selectedIcon = Icons.spa;

  final List<Color> _colors = [
    const Color(0xFF76D7C4), const Color(0xFFF7CAC9), const Color(0xFF8A9A5B),
    const Color(0xFFF5B7B1), const Color(0xFFD2B4DE), const Color(0xFFA9CCE3),
    const Color(0xFFFAD7A0), const Color(0xFFFFC0CB),
  ];

  final List<IconData> _icons = [
    Icons.spa, Icons.fitness_center, Icons.book, Icons.self_improvement,
    Icons.water_drop, Icons.fastfood, Icons.bedtime, Icons.directions_run,
    Icons.palette, Icons.music_note, Icons.favorite, Icons.star,
  ];

  void _addHabit() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit name.')),
      );
      return;
    }
    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      icon: _selectedIcon,
      color: _selectedColor,
    );
    context.read<HabitBloc>().add(AddHabit(newHabit));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Create New Habit',
          style: TextStyle(
            fontFamily: 'Archivo',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: _addHabit,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                fontFamily: 'Archivo',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          // Habit Name
          _buildSectionTitle('Name'),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            style: const TextStyle(fontFamily: 'Archivo', fontSize: 16),
            decoration: InputDecoration(
              hintText: 'e.g. Drink Water',
              hintStyle: TextStyle(fontFamily: 'Archivo', color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
          ),
          const SizedBox(height: 28),

          // Color Selection
          _buildSectionTitle('Color'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: _colors.map((color) {
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: color.withOpacity(0.5),
                  child: _selectedColor == color
                      ? const Icon(Icons.check, color: Colors.white, size: 28)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),

          // Icon Selection
          _buildSectionTitle('Icon'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              final icon = _icons[index];
              final isSelected = _selectedIcon == icon;
              return GestureDetector(
                onTap: () => setState(() => _selectedIcon = icon),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? _selectedColor : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    size: 30,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Archivo',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}