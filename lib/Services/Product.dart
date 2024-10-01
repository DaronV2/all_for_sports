class Product {

  final String productReference;
  final int quantity;
  final String productSupplier;
  final String locationCode;

  Product(this.productReference, this.quantity, this.productSupplier, this.locationCode);

  Product.fromJson(Map<String,dynamic> json)
    : productReference = json['ProductReference'] as String,
      quantity = json['stockQuantity'] as int,
      productSupplier = json['ProductSupplier'] as String,
      locationCode = json['LocationCode'] as String;

}