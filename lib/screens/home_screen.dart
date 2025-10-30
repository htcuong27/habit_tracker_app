import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_app/screens/add_habit_screen.dart';
import '../bloc/habits/habit_bloc.dart';
import '../bloc/habits/habit_state.dart';
import '../bloc/habits/habit_event.dart';
import '../widgets/habit_tile.dart';
import '../widgets/streak_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Today',
          style: GoogleFonts.archivo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StreakCard(),
            const SizedBox(height: 24),
            Text(
              'To-Do List',
              style: GoogleFonts.archivo(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<HabitBloc, HabitState>(
                builder: (context, state) {
                  if (state is HabitsLoadInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HabitsLoadSuccess) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        final habit = state.habits[index];
                        return HabitTile(
                          habit: habit,
                          onCompleted: () {
                            context.read<HabitBloc>().add(ToggleHabitCompletion(habit));
                          },
                        );
                      },
                    );
                  } else if (state is HabitsLoadFailure) {
                    return const Center(child: Text('Failed to load habits.'));
                  } else {
                    return const Center(child: Text('Something went wrong.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}