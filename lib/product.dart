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