import 'package:madivizion_jdonuts_app/core/result/result.dart';

/// Names of the horizontal rows on Home. Values match the seed JSON.
abstract final class HomeSections {
  static const String seasonal = 'seasonal';
  static const String popular = 'popular';
  static const String orderAgain = 'orderAgain';
}

/// The one member row Home and Rewards share.
class MemberProfile {
  const MemberProfile({
    required this.name,
    required this.photoUrl,
    required this.tier,
    required this.nextTier,
    required this.pointsToNextTier,
    required this.notificationCount,
  });

  final String name;
  final String photoUrl;
  final String tier;
  final String nextTier;
  final int pointsToNextTier;
  final int notificationCount;
}

/// A product card in a Home row.
class HomeProduct {
  const HomeProduct({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.discountPercent,
  });

  final String id;
  final String name;
  final String imageUrl;
  final int? discountPercent;
}

/// One slide in the Home carousel.
class HomeBanner {
  const HomeBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String imageUrl;
}

/// A nearby shop. The card is display-only.
class HomeShop {
  const HomeShop({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;
}

/// Home as read from Drift. Each block can fail on its own.
class HomeFeed {
  const HomeFeed({
    required this.member,
    required this.seasonal,
    required this.popular,
    required this.orderAgain,
    required this.banners,
    required this.shops,
  });

  final Result<MemberProfile> member;
  final Result<List<HomeProduct>> seasonal;
  final Result<List<HomeProduct>> popular;
  final Result<List<HomeProduct>> orderAgain;
  final Result<List<HomeBanner>> banners;
  final Result<List<HomeShop>> shops;
}
