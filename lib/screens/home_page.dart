import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoppy/screens/cart_page.dart';
import 'package:shoppy/screens/categories.dart';
import 'package:shoppy/screens/product_categories.dart';
import 'package:shoppy/screens/product_view.dart';
import 'package:shoppy/widgets/search_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();
  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome User',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.centerLeft,
            height: 160,
            width: 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFFF05152),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Best Seller!',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Discover the perfect\nshopping journey!',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductCategories()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Text(
                        'Shop Now!',
                        style: GoogleFonts.poppins(
                          fontSize: 11.0,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                Icon(Icons.category, color: Colors.pinkAccent),
                SizedBox(width: 10),
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 160,
            width: 370,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.watch),
                          onPressed: () {
                            // Add your onPressed logic here

                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Watches',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_bag),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Bags',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.gite_rounded),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Beauty',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.dark_mode_outlined),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Clothing',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.sunny),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Accessories',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.snowshoeing_sharp),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Shoes',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'Lifestyle',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.more_horiz_outlined),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          iconSize: 20,
                        ),
                        // Adjust the spacing between IconButton and Text
                        Text(
                          'More',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Icon(Icons.thumb_up_alt_outlined, color: Colors.pinkAccent),
                SizedBox(width: 10),
                Text('Recommended',
                    style: GoogleFonts.poppins(
                        fontSize: 18.0, fontWeight: FontWeight.w500)),
                SizedBox(width: 120),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductCategories(),
                          )
                      );
                    },
                    child: Text('See more',
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          color: Colors.pinkAccent.withOpacity(0.8),
                        ))),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('products')
                    .doc('ERInsAZ7p1tCm3kdeJmC')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final productData =
                      snapshot.data?.data() as Map<String, dynamic>?;
                  if (productData != null) {
                    // Add your content for the first product here...
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: snapshot.data!), // Pass product data to product view page
                          ),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Image.network(
                          productData['image'] as String,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('products')
                    .doc('Kwo9ECQ4ZZBsOfhWbphb')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final productData =
                      snapshot.data?.data() as Map<String, dynamic>;
                  if (productData != null) {
                    // Add your content for the second product here...
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: snapshot.data!), // Pass product data to product view page
                          ),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Image.network(
                          productData['image'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
