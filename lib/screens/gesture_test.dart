import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  final DocumentSnapshot product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product['image'],
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                product['name'],
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                ' \$${product['price']}',
                style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.w700,color: Colors.pinkAccent),
              ),
              SizedBox(height: 10),
               Text(
                'Product Description',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                product['desc'],
                style: GoogleFonts.poppins(fontSize: 16,color: Colors.black.withOpacity(0.7)),
              ),
              const SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pinkAccent),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text('Add to Cart',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.pinkAccent),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.pinkAccent,
                    ),
                    child: Text('Buy Now',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
