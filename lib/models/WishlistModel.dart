
class WishlistModel{

  String id;
  String productName;
  String image;
  var price;

  WishlistModel({required this.id,required this.productName,required this.price,required this.image});


  factory WishlistModel.fromJson(Map<String,dynamic> json){
    return WishlistModel(
        id: json['id'],
        productName: json['product_name'],
        price: json['price'],
        image: json['image']
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'product_name':productName,
      'image':image,
      'price':price
    };
  }
}