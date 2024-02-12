import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          List<Widget> productWidgets = [];

          if (snapshot.hasData) {
            final products = snapshot.data?.docs.reversed.toList();
            for (var product in products!) {
              final productName = product['name'];
              final productPrice = product['Price'];
              final productImage = product['image'];

              final productWidget = ListTile(
                title: Text(productName),
                subtitle: Text('Price: $productPrice'),
                leading: productImage != null ? Image.network(productImage) : null,
              );
              productWidgets.add(productWidget);
            }
          }

          return ListView(
            children: productWidgets,
          );
        },
      ),
    );
  }
}
