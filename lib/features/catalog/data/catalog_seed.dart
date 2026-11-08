import 'dart:convert';

/// Catalog JSON before it is written into Drift.
class CatalogSeed {
  CatalogSeed({
    required this.member,
    required this.tiers,
    required this.banners,
    required this.products,
    required this.shops,
    required this.challenges,
  });

  factory CatalogSeed.parse(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map) {
      throw const FormatException('catalog must be an object');
    }
    final json = Map<String, Object?>.from(decoded);
    return CatalogSeed(
      member: SeedMember.fromJson(_object(json, 'member')),
      tiers: _objects(json, 'tiers').map(SeedTier.fromJson).toList(),
      banners: _objects(json, 'banners').map(SeedBanner.fromJson).toList(),
      products: _objects(json, 'products').map(SeedProduct.fromJson).toList(),
      shops: _objects(json, 'shops').map(SeedShop.fromJson).toList(),
      challenges: _objects(
        json,
        'challenges',
      ).map(SeedChallenge.fromJson).toList(),
    );
  }

  final SeedMember member;
  final List<SeedTier> tiers;
  final List<SeedBanner> banners;
  final List<SeedProduct> products;
  final List<SeedShop> shops;
  final List<SeedChallenge> challenges;
}

class SeedMember {
  const SeedMember({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.tier,
    required this.nextTier,
    required this.points,
    required this.pointsToNextTier,
    required this.notificationCount,
    required this.rewardsBadgeCount,
  });

  factory SeedMember.fromJson(Map<String, Object?> json) {
    return SeedMember(
      id: _text(json, 'id'),
      name: _text(json, 'name'),
      photoUrl: _text(json, 'photoUrl'),
      tier: _text(json, 'tier'),
      nextTier: _text(json, 'nextTier'),
      points: _count(json, 'points'),
      pointsToNextTier: _count(json, 'pointsToNextTier'),
      notificationCount: _count(json, 'notificationCount'),
      rewardsBadgeCount: _count(json, 'rewardsBadgeCount'),
    );
  }

  final String id;
  final String name;
  final String photoUrl;
  final String tier;
  final String nextTier;
  final int points;
  final int pointsToNextTier;
  final int notificationCount;
  final int rewardsBadgeCount;
}

class SeedTier {
  const SeedTier({
    required this.id,
    required this.name,
    required this.caption,
    required this.sortOrder,
  });

  factory SeedTier.fromJson(Map<String, Object?> json) {
    return SeedTier(
      id: _text(json, 'id'),
      name: _text(json, 'name'),
      caption: _text(json, 'caption'),
      sortOrder: _count(json, 'sortOrder'),
    );
  }

  final String id;
  final String name;
  final String caption;
  final int sortOrder;
}

class SeedBanner {
  const SeedBanner({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.sortOrder,
  });

  factory SeedBanner.fromJson(Map<String, Object?> json) {
    return SeedBanner(
      id: _text(json, 'id'),
      title: _text(json, 'title'),
      imageUrl: _text(json, 'imageUrl'),
      sortOrder: _count(json, 'sortOrder'),
    );
  }

  final String id;
  final String title;
  final String imageUrl;
  final int sortOrder;
}

class SeedProduct {
  const SeedProduct({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.discountPercent,
    required this.imageUrl,
    required this.description,
    required this.homeSection,
    required this.sortOrder,
  });

  factory SeedProduct.fromJson(Map<String, Object?> json) {
    return SeedProduct(
      id: _text(json, 'id'),
      code: _text(json, 'code'),
      name: _text(json, 'name'),
      priceMmk: _count(json, 'priceMmk'),
      isNew: json['isNew'] == true,
      discountPercent: _optionalCount(json, 'discountPercent'),
      imageUrl: _text(json, 'imageUrl'),
      description: _text(json, 'description'),
      homeSection: _optionalText(json, 'homeSection'),
      sortOrder: _count(json, 'sortOrder'),
    );
  }

  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final String imageUrl;
  final String description;
  final String? homeSection;
  final int sortOrder;
}

class SeedShop {
  const SeedShop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.sortOrder,
  });

  factory SeedShop.fromJson(Map<String, Object?> json) {
    return SeedShop(
      id: _text(json, 'id'),
      name: _text(json, 'name'),
      imageUrl: _text(json, 'imageUrl'),
      sortOrder: _count(json, 'sortOrder'),
    );
  }

  final String id;
  final String name;
  final String imageUrl;
  final int sortOrder;
}

class SeedChallenge {
  const SeedChallenge({
    required this.id,
    required this.title,
    required this.progress,
    required this.goal,
    required this.points,
    required this.artwork,
    required this.tab,
    required this.sortOrder,
  });

  factory SeedChallenge.fromJson(Map<String, Object?> json) {
    return SeedChallenge(
      id: _text(json, 'id'),
      title: _text(json, 'title'),
      progress: _count(json, 'progress'),
      goal: _count(json, 'goal'),
      points: _count(json, 'points'),
      artwork: _text(json, 'artwork'),
      tab: _text(json, 'tab'),
      sortOrder: _count(json, 'sortOrder'),
    );
  }

  final String id;
  final String title;
  final int progress;
  final int goal;
  final int points;
  final String artwork;
  final String tab;
  final int sortOrder;
}

Map<String, Object?> _object(Map<String, Object?> json, String key) {
  return _asObject(json[key], 'catalog $key must be an object');
}

List<Map<String, Object?>> _objects(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is! List) {
    throw FormatException('catalog $key must be a list');
  }
  return value.map(_asObject).toList();
}

Map<String, Object?> _asObject(Object? value, [String? message]) {
  if (value is! Map) {
    throw FormatException(message ?? 'catalog list item must be an object');
  }
  return Map<String, Object?>.from(value);
}

String _text(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is! String || value.isEmpty) {
    throw FormatException('catalog $key must be text');
  }
  return value;
}

String? _optionalText(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value == null) {
    return null;
  }
  if (value is! String) {
    throw FormatException('catalog $key must be text');
  }
  return value;
}

int _count(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is! int) {
    throw FormatException('catalog $key must be an integer');
  }
  return value;
}

int? _optionalCount(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value == null) {
    return null;
  }
  if (value is! int) {
    throw FormatException('catalog $key must be an integer');
  }
  return value;
}
