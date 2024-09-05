import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/api_services.dart';
import 'package:shopping_cart_app/service/model/product_model.dart';
import 'package:shopping_cart_app/service/screens/add_prod_page.dart';

class ProductListPage extends StatefulWidget {
  final String userLoginToken;

  ProductListPage({required this.userLoginToken});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ApiService apiService = ApiService();
  late Future<List<Product>> productList;

  @override
  void initState() {
    super.initState();
    productList = apiService.getProductList(widget.userLoginToken);
  }

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(
          userLoginToken: widget.userLoginToken,
          product: product, // Pass product data to AddProductPage
        ),
      ),
    ).then((_) {
      // Refresh product list after editing
      setState(() {
        productList = apiService.getProductList(widget.userLoginToken);
      });
    });
  }

  void _deleteProduct(String productId) async {
    final success =
        await apiService.deleteProduct(widget.userLoginToken, productId);
    if (success) {
      // Refresh the product list after deletion
      setState(() {
        productList = apiService.getProductList(widget.userLoginToken);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Product>? products = snapshot.data;
            return ListView.builder(
              itemCount: products?.length ?? 0,
              itemBuilder: (context, index) {
                Product product = products![index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/img1.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16), // Space between image and text
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text('Price: ${product.price}'),
                                  Text('MOQ: ${product.moq}'),
                                  Text(
                                      'Discounted Price: ${product.discountedPrice}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16), // Space between image and buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                _editProduct(product); // Edit action
                              },
                              icon: Icon(Icons.edit),
                              label: Text('Edit'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _deleteProduct(product.id); // Delete action
                              },
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}
