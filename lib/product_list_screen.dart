import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_36/add_product_screen.dart';
import 'package:flutter_application_36/update_product_screen%20.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getproductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product List'),
        ),
        body: Visibility(
          visible: _getproductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return _buildProductItem(productList[index]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),
            );
          },
          child: Icon(Icons.add),
        ));
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getproductListInProgress = true;
    setState(() {});
    const String getProductListurl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(getProductListurl);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final jsonproductList = decodedData['data'];
      for (Map<String, dynamic> p in jsonproductList) {
        Product product = Product(
            id: p['_id'] ?? 'unknown',
            productName: p['ProductName'] ?? 'unknown',
            productCode: p['ProductCode'] ?? 'unknown',
            image: p['Img'] ?? 'unknown',
            unitPrice: p['UnitPrice'] ?? 'unknown',
            totalPrice: p['TotalPrice'],
            quantity: p['Qty'] ?? 'unknown');
        productList.add(product);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Get product list failed! Try again!')));
    }
    _getproductListInProgress = false;
    setState(() {
      
    });
  }

  Widget _buildProductItem( Product product) {
    return ListTile(
      // leading: Image.network(
      //   product.image,
      //   height: 50,
      //   width: 50,
      // ),
      title: Text(product.productName),
      subtitle: Wrap(
        spacing: 15,
        children: [
          Text('Unit price: ${product.unitPrice}'),
          Text('Quantity: ${product.quantity}'),
          Text('Total Price: ${product.totalPrice}')
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProductScreen()));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure that you want to delete this product?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.orange),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Yes, delete',
                    style: TextStyle(color: Colors.orange),
                  ))
            ],
          );
        });
  }
}

class Product {
  // "_id": "665210685d34875ba9ea45f0",
  // "ProductName": "[",
  // "ProductCode": "]",
  // "Img": "]",
  // "UnitPrice": "]",
  // "Qty": "]",
  // "TotalPrice": "[",
  // "CreatedDate": "2024-05-23T14:56:20.001Z"
  final String id;
  final String productName;
  final String productCode;
  final String image;
  final String unitPrice;
  final String quantity;
  final String totalPrice;

  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.image,
      required this.unitPrice,
      required this.totalPrice,
      required this.quantity});
}
