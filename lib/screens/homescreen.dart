import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/screens/add_prod_page.dart';
import 'package:shopping_cart_app/service/screens/prod_list_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Product List'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListPage(
                              userLoginToken:
                                  'c2a2f674c6f6a1d2374da1ebfab69adc',
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductPage(
                              userLoginToken: '',
                            )));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to shopping cart App!'),
      ),
    );
  }
}
