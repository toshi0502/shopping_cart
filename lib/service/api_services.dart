import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_app/service/model/product_model.dart';

class ApiService {
  final String _baseUrl = 'https://shareittofriends.com/demo/flutter';

  Future<bool> register(
      String name, String email, String mobile, String password) async {
    final url = Uri.parse('$_baseUrl/Register.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Registration successful: $responseData');
      return true;
    } else {
      print('Registration failed: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/Login.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Login successful: $responseData');
      return true;
    } else {
      print('Login failed: ${response.statusCode}');
      return false;
    }
  }

  Future<List<Product>> getProductList(String token) async {
    final url = Uri.parse('$_baseUrl/productList.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'user_login_token': token,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> productData = jsonDecode(response.body);
      return productData.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<bool> addProduct(String token, String name, String moq, String price,
      String discountedPrice) async {
    final url = Uri.parse('$_baseUrl/addProduct.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'user_login_token': token,
        'name': name,
        'moq': moq,
        'price': price,
        'discounted_price': discountedPrice,
      },
    );

    if (response.statusCode == 200) {
      print('Product added successfully');
      return true;
    } else {
      print('Failed to add product: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> editProduct(String token, String id, String name, String moq,
      String price, String discountedPrice) async {
    final url = Uri.parse('$_baseUrl/editProduct.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'user_login_token': token,
        'id': id,
        'name': name,
        'moq': moq,
        'price': price,
        'discounted_price': discountedPrice,
      },
    );

    if (response.statusCode == 200) {
      print('Product updated successfully');
      return true;
    } else {
      print('Failed to update product: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> deleteProduct(String token, String id) async {
    final url = Uri.parse('$_baseUrl/deleteProduct.php');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'user_login_token': token,
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      print('Product deleted successfully');
      return true;
    } else {
      print('Failed to delete product: ${response.statusCode}');
      return false;
    }
  }
}
