import 'package:bhopal/product.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedImage;

  List<String> _availableImages = [
    'product1.png',
    'product2.png',
    'product3.png',
  ];

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final price = double.parse(_priceController.text);
      final image = _selectedImage!;

      final newProduct = Product(name: name, price: price, image: image);
      Navigator.pop(context, newProduct);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text('Select Image'),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _availableImages.map((image) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color:
                            _selectedImage == image ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset('assets/flower2.png'),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
