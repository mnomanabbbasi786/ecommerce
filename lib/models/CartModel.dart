
class CartModel{

  final String id;
  final String productName;
   var price;
  final int quantity;
  final String image;
  CartModel({required this.id,required this.productName,required this.price,required this.quantity, required this.image});



  factory CartModel.fromJson(Map<String,dynamic> json){
    return CartModel(
        id: json['id'],
        productName: json['product_name'],
        price: json['price'],
        quantity: json['quantity'],
      image: json['image']
    );
  }



  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'product_name':productName,
      'price':price,
      'quantity':quantity,
      'image':image
    };
  }

}