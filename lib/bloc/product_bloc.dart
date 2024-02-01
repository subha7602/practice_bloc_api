import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bllloc/bloc/product_event_bloc.dart';
import 'package:practice_bllloc/bloc/product_state_bloc.dart';

import '../data/product.dart';
import '../repo/product_sevice.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService = ProductService();

  ProductBloc() : super(LoadingState()) {
    on<OnPressed>(_onPressed);
  }

  void _onPressed(
      OnPressed event,
      Emitter<ProductState> emit,
      ) async {
    if(state is SuccessState) return;
    emit(LoadingState());

    try {
      await Future.delayed(Duration(seconds: 2)).then((_) async {
        final List<Product> products = await _productService.fetchProducts();
       // if (!emit.isDone) {

          emit(SuccessState(products));
       // }
      });
    } catch (e) {
      if (!emit.isDone) {
        emit(FailureState(e.toString()));
      }
    }
  }
}

