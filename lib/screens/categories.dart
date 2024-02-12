import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 44.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 1.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_sharp, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          hintText: "What are you looking for?"),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.pinkAccent),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Filter',
                          style: GoogleFonts.poppins(
                              color: Colors.pinkAccent, fontSize: 18.0),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.snowshoeing),
                    ),
                    Text('Shoes'),
                  ],
                ),
                Column(
                  children: [],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
