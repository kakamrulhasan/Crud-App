import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_36/add_product_screen.dart';
import 'package:flutter_application_36/update_product_screen%20.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildProductItem();
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductItem() {
    return ListTile(
      leading: Image.network(
        'https://i.pinimg.com/736x/48/26/10/482610f1561ea3ad53fdcb3d88736c51.jpg',
        height: 50,
        width: 50,
      ),
      title: Text('Product Name'),
      subtitle: Wrap(
        spacing: 15,
        children: [
          Text('Unit price 100'),
          Text('Quantity 100'),
          Text('Total Price: 1000')
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
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Yes, delete'))
            ],
          );
        });
  }
}
