import '../data/product.dart';

abstract class ProductState{

}
class LoadingState extends ProductState{

}
class SuccessState extends ProductState{
  final List<Product> products;

  SuccessState(this.products);

}
class FailureState extends ProductState{
  final String error;

  FailureState(this.error);
}