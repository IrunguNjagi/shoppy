import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:shoppy/services/firebase_services.dart';
import 'package:shoppy/widgets/custom_action_bar.dart';

class ProductDetailPage extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<DocumentSnapshot> _fetchProductDetails() async {
    return _firebaseServices.productsRef.doc(widget.product.id).get();
  }


  Future<void> _checkIfSaved() async {
    try {
      final snapshot = await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection('Saved')
          .doc(widget.product.id)
          .get();

      setState(() {
        _isSaved = snapshot.exists;
      });
    } catch (e) {
      print('Error checking if product is saved: $e');
    }
  }

  Future<void> _addtoCart() async {
    try {
      await _firebaseServices.addToCart(widget.product.id);
      print('Product added to cart');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to cart'),
          duration: Duration(seconds: 4),
        ),
      );
    } catch (e) {
      print('Error adding product to cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _addtoSaved() async {
    setState(() {
      _isSaved = !_isSaved;
    });

    if (_isSaved) {
      // Add the item to the 'Saved' collection
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection('Saved')
          .doc(widget.product.id)
          .set({
        'productId': widget.product.id,
        // Add other relevant data if needed
      });
      print('Product Saved');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product Saved'),
          duration: Duration(seconds: 4),
        ),
      );
    } else {
      // Remove the item from the 'Saved' collection
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection('Saved')
          .doc(widget.product.id)
          .delete();
      print('Product removed from saved');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product removed from saved'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  /*Future<void> _addtoSaved() async {
    try {
      await _firebaseServices.addToSaved(widget.product.id);
      print('Product Saved');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product Saved'),
          duration: Duration(seconds: 4),
        ),
      );
    } catch (e) {
      print('Error saving product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save product'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomActionBar(
                    hasBackArrow: true,
                    hasTitle: true,
                    hasBackground: false,
                    title: productData['name'],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          productData['image'],
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productData['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _addtoSaved();
                              },
                              child: Icon(
                                Icons.favorite,
                                color: _isSaved ? Colors.pinkAccent : Colors.grey,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          ' \$${productData['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Product Description',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          productData['desc'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: _addtoCart,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.pinkAccent),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  'Add to Cart',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.pinkAccent,
                              ),
                              child: Text(
                                'Buy Now',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
