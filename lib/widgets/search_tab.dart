import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screens/product_view.dart';
import 'package:shoppy/services/firebase_services.dart';
import 'package:shoppy/widgets/constants.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  void refreshPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8.0,
        left: 40,
        right: 40,
        bottom: 40,
      ),
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: Constants.regularDarkStyle,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef
                    .orderBy('search_string')
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error : ${snapshot.hasError}"),
                      ),
                    );
                  }
                  //Collection data ready to display
                  if (snapshot.connectionState == ConnectionState.done) {
                    //Display data inside a ListView
                    return ListView(
                      padding: EdgeInsets.only(
                        top: 108,
                        bottom: 12.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: document),
                                ));
                          },
                          child: FutureBuilder(
                            future: _firebaseServices.productsRef
                                .doc(document.id)
                                .get(),
                            builder: (context, productSnap) {
                              if (productSnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productSnap.error}"),
                                  ),
                                );
                              }
                              ;

                              if (productSnap.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> _productMap =
                                    productSnap.data!.data()
                                        as Map<String, dynamic>;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "${_productMap['image']}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_productMap['name']}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4.0,
                                                  ),
                                                  child: Text(
                                                    "\$${_productMap['price']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.0,
                                                      color: Colors.pinkAccent,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*IconButton(
                                        onPressed: () {
                                          _firebaseServices.usersRef
                                              .doc(
                                                  _firebaseServices.getUserId())
                                              .collection('Cart')
                                              .doc(document.id)
                                              .delete();
                                          refreshPage();
                                        },
                                        icon: Icon(Icons.delete),
                                      ),*/
                                    ],
                                  ),
                                );
                              }
                              ;

                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }

                  //Loading State
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          Padding(
            padding: const EdgeInsets.only(
              top: 45,
            ),
            child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search for product",
                    fillColor: Colors.grey[100]),
                onSubmitted: (value) {
                  setState(() {
                    _searchString = value.toLowerCase();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
