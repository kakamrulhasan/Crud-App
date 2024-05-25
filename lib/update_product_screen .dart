import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_36/product.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;
  @override
  void initState() {
    // TODO: implement initState

    _nameTEController.text = widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _quantityTEController.text = widget.product.quantity;
    _totalPriceTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.image;
    _productCodeTEController.text = widget.product.productCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
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
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'product code', labelText: 'product code'),
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
                  visible: _updateProductInProgress = true ,
                  
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      
                      if (_formKey.currentState!.validate()) {
                        _updateProduct(); 
                      }
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Map<String, String> inputData = {
      "Img": _imageTEController.text,
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };
    String updateProductUrl =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product has been undated!'),
      ));
      Navigator.pop(context ,true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Update product failed! Try Again!'),
      ));
    }
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
}
