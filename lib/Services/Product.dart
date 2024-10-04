class Product {

  final String productReference;
  final int quantity;
  final String description;
  final String productSupplier;
  final StorageLocation? storage;
  final String addingDate;

  Product(this.productReference, this.quantity, this.description, this.productSupplier, this.storage, this.addingDate);

  Product.fromJson(Map<String,dynamic> json)
    : productReference = json['ProductReference'] as String,
      quantity = json['stockQuantity'] as int,
      description = json['Description'] as String,
      productSupplier = json['ProductSupplier'] as String,
      storage = json['StorageLocation'] != null ? StorageLocation.fromJson(json['StorageLocation']) : null,
      addingDate = json['AddingDate'] as String;
}

class StorageLocation {
  String? location;
  String? module;
  String? aisle;
  int? row;
  int? section;
  String? locationCode;

  StorageLocation(
      {this.location,
      this.module,
      this.aisle,
      this.row,
      this.section,
      this.locationCode});

  StorageLocation.fromJson(Map<String, dynamic> json) {
    location = json['Location'];
    module = json['Module'];
    aisle = json['Aisle'];
    row = json['Row'];
    section = json['Section'];
    locationCode = json['LocationCode'];
  }
}