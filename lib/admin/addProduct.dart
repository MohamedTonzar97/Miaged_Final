import '../models/product.dart';
import '../widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _imageLocation,_taille,_marque;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _price = value;
              },
              hint: 'Product Price',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _description = value;
              },
              hint: 'Product Description',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _category = value;
              },
              hint: 'Product Category',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value) {
                _imageLocation = value;
              },
              hint: 'Product Location',
            ),CustomTextField(
              onClick: (value) {
                _taille = value;
              },
              hint: 'Taille',
            ),CustomTextField(
              onClick: (value) {
                _taille = value;
              },
              hint: 'Marque',
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                      pTitre: _name,
                      pPrice: _price,
                      pTaille: _taille,
                      pDescription: _description,
                      pMarque: _marque,
                      pLocation: _imageLocation,
                      pCategory: _category));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}

