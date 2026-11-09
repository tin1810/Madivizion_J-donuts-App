/// The member points, tier ladder, and challenges stored for Home.
class RewardsBoard {
  const RewardsBoard({
    required this.points,
    required this.badgeCount,
    required this.currentTierId,
    required this.tiers,
    required this.challenges,
  });

  final int points;
  final int badgeCount;
  final String currentTierId;
  final List<RewardTier> tiers;
  final List<RewardChallenge> challenges;

  List<RewardChallenge> challengesFor(String tab) {
    return [
      for (final item in challenges)
        if (item.tab == tab) item,
    ];
  }
}

/// One rung on the Silver, Gold, Platinum ladder.
class RewardTier {
  const RewardTier({
    required this.id,
    required this.name,
    required this.caption,
  });

  final String id;
  final String name;
  final String caption;
}

/// One earn or gift card. [artwork] is [RewardArtwork.donut] or coffee.
class RewardChallenge {
  const RewardChallenge({
    required this.id,
    required this.title,
    required this.progress,
    required this.goal,
    required this.points,
    required this.artwork,
    required this.tab,
  });

  final String id;
  final String title;
  final int progress;
  final int goal;
  final int points;
  final String artwork;
  final String tab;

  bool get complete => goal > 0 && progress >= goal;

  double get fraction {
    if (goal <= 0) {
      return 0;
    }
    final value = progress / goal;
    if (value < 0) {
      return 0;
    }
    if (value > 1) {
      return 1;
    }
    return value;
  }
}

/// Values stored in the catalog seed.
abstract final class RewardArtwork {
  static const String donut = 'donut';
  static const String coffee = 'coffee';
}

/// Values stored in the catalog seed.
abstract final class RewardTabs {
  static const String earn = 'earn';
  static const String gift = 'gift';
}
