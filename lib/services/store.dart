import '../models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   Store();
  addProduct(Product product) {
    _firestore.collection('Products').add({
      'productName': product.pTitre,
      'productDescription': product.pDescription,
      'productTaile': product.pTaille,
      'productLocation': product.pLocation,
      'productCategory': product.pCategory,
      'productPrice': product.pPrice,
      'productMarque': product.pMarque,
    });
  }


  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection('Products').snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection('Orders').snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore.collection('Orders')
        .doc(documentId)
        .collection('OrderDetails')
        .snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection('Products').doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore.collection('Products')
        .doc(documentId)
        .update(data);
  }

    storeOrders(data, List<Product> products) {
      var documentRef = _firestore.collection('Orders').doc();
      documentRef.set(data);
      for (var product in products) {
        documentRef.collection('OrderDetails').doc().set({
          'productName': product.pTitre,
          'productPrice': product.pPrice,
          'Quantity': product.pQuantity,
          'productLocation': product.pLocation,
          'productCategory': product.pCategory,
        });
      }
    }


  }




