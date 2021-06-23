class ProductsModel{
  int id;
  String name, image, description, price;

  ProductsModel(this.id, this.name, this.description, this.image, this.price);

  ProductsModel.fromJson(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
    this.description = map['description'];
    this.price = map['price'];
  }
}
