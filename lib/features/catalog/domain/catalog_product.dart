/// A product opened from `/product/:id`.
class CatalogProduct {
  const CatalogProduct({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    required this.imageUrl,
    required this.description,
  });

  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final String imageUrl;
  final String description;

  @override
  bool operator ==(Object other) {
    return other is CatalogProduct &&
        other.id == id &&
        other.code == code &&
        other.name == name &&
        other.priceMmk == priceMmk &&
        other.isNew == isNew &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, priceMmk, isNew, imageUrl, description);
}

/// Shared by the Home tile and the detail image so the flight can run.
String productHeroTag(String id) => 'product-$id';

/// Groups [amount] with thousands separators, such as `3200` to `3,200`.
String formatMmkAmount(int amount) {
  final digits = amount.abs().toString();
  final grouped = StringBuffer();
  for (var index = 0; index < digits.length; index++) {
    final remaining = digits.length - index;
    if (index > 0 && remaining % 3 == 0) {
      grouped.write(',');
    }
    grouped.write(digits[index]);
  }
  return grouped.toString();
}
