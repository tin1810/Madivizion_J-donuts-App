import 'package:integration_test/integration_test.dart';
import '../test/features/auth/presentation/register_home_product.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  registerThenOpenProduct();
}
