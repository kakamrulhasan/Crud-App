import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      InputDecoration(hintText: 'Name', labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: 'code', labelText: 'code'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Unit Price', labelText: 'Unit Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product unit price';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Quantity', labelText: 'Quatity'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Total Price', labelText: 'Total Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product Total Price';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _imageTEController,
                  decoration:
                      InputDecoration(hintText: 'Image', labelText: 'Image'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'write your product Image';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: _addNewProductInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print('click');
                      if (_formKey.currentState!.validate()) {
                        _addProduct();
                      }
                    },
                    child: Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    _addNewProductInProgress = true;
    setState(() {});
    String addNewProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Map<String, dynamic> inputData = {
      'ProductName': _nameTEController.text,
      'Img': _imageTEController.text.trim(),
      'ProductCode': _productCodeTEController.text,
      'Qty': _quantityTEController.text,
      'TotalPrice': _totalPriceTEController.text,
      'UnitPrice': _unitPriceTEController.text
    };
    Uri uri = Uri.parse(addNewProductUrl);
    Response response = await post(uri,
        body: jsonEncode(inputData),
        headers: {'content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);
    print(response.headers);
    _addNewProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      _nameTEController.clear();
      _unitPriceTEController.clear();
      _totalPriceTEController.clear();
      _productCodeTEController.clear();
      _quantityTEController.clear();
      _imageTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New product added!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Add New product added failed! Try Again!'),
      ));
    }
  }
}
