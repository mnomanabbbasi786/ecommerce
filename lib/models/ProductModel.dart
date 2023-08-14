class ProductModel {
  var id;
  var bar_code;
  var sellPrice;
  var productName;
  var rrPrice;
  var stock;
  var image;
  var category_name;
  var description;
  ProductModel(
      { this.id,
        this.sellPrice,
        this.bar_code,
        this.productName,
        this.rrPrice,
        this.stock,
        this.category_name,
        this.description,
        this.image});

// Factory constructor to create a Product Model instance from JSON

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        id: json['id'],
        sellPrice: json['sell_price'],
        bar_code: json['bar_code'],
        productName: json['product_name'],
        rrPrice: json['rr_price'],
        category_name: json['category_name'],
        stock: json['stock'],
        image: json['image'],
      description: json['description']
    );
  }

  static List<List<dynamic>> convertProductModelToList(ProductModel product) {
    return [
      [
        product.id,
        product.sellPrice,
        product.bar_code,
        product.productName,
        product.rrPrice,
        product.stock,
        product.category_name,
        product.image,
      ],
    ];
  }


// Method to convert a ProductModel instance to a JSON representation

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'bar_code':bar_code,
      'product_name':productName,
      'rr_price':rrPrice,
      'sell_price':sellPrice,
      'stock':stock,
      'image':image,
      'category_name':category_name,
      'description':description
    };
  }
}
