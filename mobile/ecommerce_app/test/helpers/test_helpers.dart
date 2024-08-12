import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [ProductRepository],
  customMocks: [MockSpec<Client>(as: #MockClient)]
)

void main() {

}