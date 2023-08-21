
class WishlistModel{

  String id;
  String productName;
  String image;
  var price;
  var userId;
  String productId;
  WishlistModel({required this.id,required this.productName,required this.price,required this.image,required this.userId,required this.productId});


  factory WishlistModel.fromJson(Map<String,dynamic> json){
    return WishlistModel(
        id: json['id'],
        productName: json['product_name'],
        price: json['price'],
        image: json['image'],
      userId: json['user_id'],
      productId: json['product_id']
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'product_name':productName,
      'image':image,
      'price':price,
      'user_id':userId,
      'product_id':productId
    };
  }
}