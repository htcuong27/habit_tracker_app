
class User {
  final String name;
  final String bio;
  final String country;
  final int level;
  final int xp;
  final int xpLimit;
  final int coins;
  final int currentStreak;
  final int totalHours;
  final int pododorosCompleted;
  final Map<DateTime, int> studyActivity;
  final int giftsSent;
  final int giftsReceived;

  User({
    required this.name,
    required this.bio,
    required this.country,
    required this.level,
    required this.xp,
    required this.xpLimit,
    required this.coins,
    required this.currentStreak,
    required this.totalHours,
    required this.pododorosCompleted,
    required this.studyActivity,
    required this.giftsSent,
    required this.giftsReceived,
  });
}
