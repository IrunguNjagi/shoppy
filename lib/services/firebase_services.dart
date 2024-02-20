import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String? getUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  final CollectionReference productsRef =
  FirebaseFirestore.instance.collection('products');

  final CollectionReference usersRef =
  FirebaseFirestore.instance.collection('Users');

  Future<void> addToCart(String productId) async {
    String? userId = getUserId();
    if (userId != null) {
      await usersRef
          .doc(userId)
          .collection('Cart')
          .doc(productId)
          .set({'added_at': Timestamp.now()});
    } else {
      throw Exception('User not logged in');
    }
  }
}
