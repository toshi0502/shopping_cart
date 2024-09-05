import 'package:flutter/material.dart';
import 'package:shopping_cart_app/service/api_services.dart';
import 'package:shopping_cart_app/service/model/product_model.dart';

class AddProductPage extends StatefulWidget {
  final String userLoginToken;
  final Product? product; //

  AddProductPage({required this.userLoginToken, this.product});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _moqController;
  late TextEditingController _priceController;
  late TextEditingController _discountedPriceController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers, if product exists, pre-fill the form fields
    _nameController = TextEditingController(
        text: widget.product != null ? widget.product!.name : '');
    _moqController = TextEditingController(
        text: widget.product != null ? widget.product!.moq : '');
    _priceController = TextEditingController(
        text: widget.product != null ? widget.product!.price : '');
    _discountedPriceController = TextEditingController(
        text: widget.product != null ? widget.product!.discountedPrice : '');
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String moq = _moqController.text;
      String price = _priceController.text;
      String discountedPrice = _discountedPriceController.text;

      if (widget.product != null) {
        // Edit existing product
        await apiService.editProduct(widget.userLoginToken, widget.product!.id,
            name, moq, price, discountedPrice);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product updated successfully')));
      } else {
        // Add new product
        await apiService.addProduct(
            widget.userLoginToken, name, moq, price, discountedPrice);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added successfully')));
      }
      Navigator.pop(context); // Return to previous page
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _moqController.dispose();
    _priceController.dispose();
    _discountedPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Edit Product' : 'Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _moqController,
                decoration: InputDecoration(labelText: 'MOQ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter MOQ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _discountedPriceController,
                decoration: InputDecoration(labelText: 'Discounted Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter discounted price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text(
                    widget.product != null ? 'Update Product' : 'Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
