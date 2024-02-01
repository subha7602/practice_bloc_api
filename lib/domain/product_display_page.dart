import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event_bloc.dart';
import '../bloc/product_state_bloc.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({super.key});

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  final ProductBloc _productBloc = ProductBloc();
  @override
  void initState() {
    // TODO: implement initState
    _productBloc.add(OnPressed());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {

            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card( // Wrap with a Card widget
                  elevation: 2.0, // Give some elevation for a shadow effect
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), // Add some margin
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Add padding inside the ListTile
                    title: Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0), // Add some styling
                    ),
                    subtitle: Text(
                      product.description,
                      style: TextStyle(fontSize: 16.0), // Add some styling
                    ),
                    trailing: Text(
                      'Rs. ${product.price.toString()}',
                      style: TextStyle(color: Colors.green, fontSize: 16.0, fontWeight: FontWeight.bold), // Add some styling
                    ),
                  ),
                );
              },
            );

          } else if (state is FailureState) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return Center(
              child: Text('Press the FAB to load products'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ProductBloc>(context).add(OnPressed());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
