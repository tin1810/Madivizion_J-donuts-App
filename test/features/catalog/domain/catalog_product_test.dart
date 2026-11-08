import 'package:flutter_test/flutter_test.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/catalog_product.dart';

void main() {
  test('prices group by thousands', () {
    expect(formatMmkAmount(3200), '3,200');
    expect(formatMmkAmount(12800), '12,800');
    expect(formatMmkAmount(100), '100');
  });
}
