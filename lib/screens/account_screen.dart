
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: GoogleFonts.archivo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('Profile'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          ),
          const ListTile(
            leading: Icon(Icons.group_outlined),
            title: Text('Find Study Room'),
            trailing: Icon(Icons.chevron_right_rounded),
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FindStudyRoomScreen())),
          ),
          const ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('App Settings'),
            trailing: Icon(Icons.chevron_right_rounded),
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AppSettingsScreen())),
          ),
          const ListTile(
            leading: Icon(Icons.people_alt_outlined),
            title: Text('Manage Friends'),
            trailing: Icon(Icons.chevron_right_rounded),
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ManageFriendsScreen())),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.star_outline_rounded, color: Colors.amber),
            title: Text('Upgrade to Plus'),
            trailing: Icon(Icons.chevron_right_rounded),
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UpgradeScreen())),
          ),
        ],
      ),
    );
  }
}
