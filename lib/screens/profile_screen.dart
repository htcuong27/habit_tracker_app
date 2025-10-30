
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock User Data
    final user = User(
      name: 'Cody',
      bio: 'Life-long learner & productivity enthusiast.',
      country: 'United States',
      level: 12,
      xp: 340,
      xpLimit: 1000,
      coins: 580,
      currentStreak: 36,
      totalHours: 142,
      pododorosCompleted: 284,
      studyActivity: { for (var i = 0; i < 365; i++) DateTime.now().subtract(Duration(days: i)) : (i % 7) + 1 },
      giftsSent: 12,
      giftsReceived: 5,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: GoogleFonts.archivo(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () { /* TODO: Navigate to Edit Profile */ },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: GoogleFonts.archivo(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(user.bio, style: GoogleFonts.archivo(fontSize: 14, color: Colors.grey[600])),
                    Text(user.country, style: GoogleFonts.archivo(fontSize: 12, color: Colors.grey[600])),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            // Level & Coins
            Row(
              children: [
                Expanded(child: _buildStatCard('Level', user.level.toString())),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Coins', user.coins.toString())),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: user.xp / user.xpLimit,
              backgroundColor: Colors.grey[200],
              color: Colors.black,
            ),
            Center(child: Text('${user.xp} / ${user.xpLimit} XP')),
            const SizedBox(height: 24),
            // Study Statistics
            Text('Study Statistics', style: GoogleFonts.archivo(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildStatRow('Current Streak', '${user.currentStreak} days'),
            _buildStatRow('Total Hours', '${user.totalHours} hrs'),
            _buildStatRow('Podomoros Completed', user.pododorosCompleted.toString()),
            const SizedBox(height: 24),
            // Study Activity
            Text('Study Activity', style: GoogleFonts.archivo(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Placeholder for GitHub-like timeline
            Container(
              height: 150,
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
              child: const Center(child: Text('Activity Timeline Placeholder')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.archivo(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.archivo(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.archivo(fontSize: 16)),
          Text(value, style: GoogleFonts.archivo(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
