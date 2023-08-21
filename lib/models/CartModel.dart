
class CartModel{

  final String id;
  final String productName;
  dynamic price;
  final int quantity;
  final String image;
  var userID;
  final String productId;
  CartModel({required this.id,required this.productName,required this.price,required this.quantity, required this.image,required this.userID,required this.productId});



  factory CartModel.fromJson(Map<String,dynamic> json){
    return CartModel(
        id: json['id'],
        productName: json['product_name'],
        price: json['price'],
        quantity: json['quantity'],
      image: json['image'],
      productId: json['product_id'],
      userID: json['user_id']
    );
  }



  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'product_name':productName,
      'price':price,
      'quantity':quantity,
      'image':image,
      'product_id':productId,
      'user_id':userID
    };
  }

}