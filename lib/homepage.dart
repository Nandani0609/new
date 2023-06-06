import 'package:bhopal/product.dart';
import 'package:flutter/material.dart';

import 'addproduct.dart';

class HomePage extends StatefulWidget {
  final String token;

  HomePage({required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = [];
  List<Product> filteredProductList = [];

  String selectedCategory = '';

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Product> getCategoryProducts(String category) {
    return productList
        .where((product) => product.category == category)
        .toList();
  }

  List<Product> getAllProducts() {
    return productList;
  }

  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    productList = [
      Product(name: 'flower', price: 10, image: 'product1.png'),
    ];
  }

  Future<void> deleteProduct(Product product) async {
    productList.remove(product);

    setState(() {
      productList = List.from(productList);
    });
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProductList = productList;
      });
    } else {
      setState(() {
        filteredProductList = productList
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void filterProducts(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<Product> getFilteredProducts() {
    if (searchQuery.isEmpty) {
      return productList;
    } else {
      return productList
          .where((product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  Widget buildProductCard(Product product) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/flower.png',
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(product.name),
            subtitle: Text('Price: \$${product.price.toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Product'),
                      content:
                          Text('Are you sure you want to delete this product?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            deleteProduct(product);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchProducts(value);
              },
              decoration: InputDecoration(
                labelText: 'Search Products',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Categories: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    selectCategory('');
                  },
                  child: Text(
                    'Show All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(8.0),
              children: selectedCategory.isEmpty
                  ? getAllProducts().map((product) {
                      return buildProductCard(product);
                    }).toList()
                  : getCategoryProducts(selectedCategory).map((product) {
                      return buildProductCard(product);
                    }).toList(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          ).then((value) {
            if (value != null && value is Product) {
              setState(() {
                productList.add(value);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
