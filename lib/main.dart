import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var product = snapshot.data!.docs[index];
              return ProductCard(
                name: product['name'],
                image: product['image'],
                price: product['price'],
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;

  ProductCard({required this.name, required this.image, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(image, width: 50, height: 50), // Assuming 'image' is a URL
        title: Text(name),
        subtitle: Text('Price: \$${price.toString()}'),
        onTap: () {
          // Add any action you want when the card is tapped
        },
      ),
    );
  }
}
