import 'package:miaged/admin/addProduct.dart';
import 'package:miaged/user/profile.dart';
import '../admin/OrdersScreen.dart';
import '../models/product.dart';
import '../authentification/LoginU.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user/cart_screen.dart';
import '../user/product_details.dart';
import '../services/store.dart';
import '../widgets/product_view.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../functions.dart';
import '../authentification/signup.dart';
import '../admin/orders_details.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products=new   List<Product>() ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.yellow,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Color(0xFFEAD20D),
              currentIndex: _bottomBarIndex,
              fixedColor: Color(0xFF181616),
              onTap: (value) {
                if (value == 1) {
                  Navigator.popAndPushNamed(context, CartScreen.id);
                }
                /*else if( value ==2)
                  {
                    SharedPreferences pref =
                    await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.signOut();
                    Navigator.popAndPushNamed(context, CartScreen.id);
                  }

                         */  setState(() {
            _bottomBarIndex = value;
            });
            },


              items: [
                      BottomNavigationBarItem(
                          label: 'Acheter', icon: Icon(Icons.shop)),
                      BottomNavigationBarItem(
                          label: 'Panier', icon: Icon(Icons.add_shopping_cart)),
                      BottomNavigationBarItem(
                          label: 'Profile ', icon: Icon(Icons.person)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Color(0xFFF8F89D),
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : Color(0xFFC1BDB8),
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Trouser',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : Color(0xFFC1BDB8),
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : Color(0xFFC1BDB8),
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : Color(0xFFC1BDB8),
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                productsView('trousers', _products),
                productsView('t-shirts', _products),
                productsView('shoes', _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Miaged'.toUpperCase(),
                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }


getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget jacketView() {
          return StreamBuilder<QuerySnapshot>(
              stream: _store.loadProducts(),
              builder: (context, snapshot) {
               if (snapshot.hasData) {
              List<Product> products = new  List<Product>();
              for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
              pId: doc.id,
              pPrice: data['productPrice'],
              pTitre: data['productName'],
              pDescription: data['productDescription'],
              pLocation: data['productLocation'],
              pCategory: data['productCategory']));
              }
          _products = [...products];
          products.clear();
          products = getProductByCategory('jackets', _products);
          return  GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: products[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child:Image.network(
                        products[index].pLocation,
                          fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(products[index].pTitre,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('\$ ${products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
           return Center(child: Text('Loading...'));
        }
      },
    );
  }
}