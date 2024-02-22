import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppy/screens/product_view.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({Key? key}) : super(key: key);

  @override
  _ProductCategoriesState createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  late String selectedCategory;

  final Map<String, IconData> categoryIcons = {
    'Shoes': FontAwesomeIcons.shoePrints,
    'Watches': Icons.watch,
    'Bags': Icons.shopping_bag,
    'Clothing': FontAwesomeIcons.shirt,
  };

  @override
  void initState() {
    super.initState();
    selectedCategory = 'Shoes';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Products')),
          bottom: TabBar(
            labelColor: Colors.pinkAccent,
            indicatorColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Popular',),
              Tab(text: 'Latest'),
              Tab(text: 'BestSeller'),
              Tab(text: 'Price' ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var category in categoryIcons.keys)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: buildCategoryItem(category, categoryIcons[category]!),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('category', isEqualTo: selectedCategory)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final products = snapshot.data?.docs;
                    if(products == null || products.isEmpty){
                      //if db has no products
                      if (snapshot.data!.docs.isEmpty) {
                        return Scaffold(
                          body: Center(
                            child: Text("Currently Sold Out!"),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        itemCount: products?.length ?? 0,
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(product: product)));

                            },
                            child: Container(
                              height: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(product['image']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: GoogleFonts.poppins(fontSize: 14.0,color: Colors.black54),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '\$${product['price']}',
                                          style: GoogleFonts.poppins(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(String category, IconData iconData) {
    return Column(
      children: [
        Icon(
          iconData,
          color: category == selectedCategory ? Colors.pinkAccent : Colors.black54,
          size: 30,
        ),
        Text(
          category,
          style: TextStyle(
            color: category == selectedCategory ? Colors.pinkAccent : Colors.grey,
          ),
        ),
      ],
    );
  }
}


