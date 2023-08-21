import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/database/CartRepositry.dart';
import 'package:ecommerce/models/CartModel.dart';
import 'package:flutter/foundation.dart';



class CartProvider extends ChangeNotifier {
  List<CartModel> _items = [];

  List<CartModel> get items => [..._items];
  int _quantity = 1;

  double _price = 0;

  double get price => _price;

  setPrice(double price){
    _price = price;
    print(price);
    notifyListeners();
  }

  int get quantity => _quantity;

  setQuantity(int productQuantity){
      _quantity = productQuantity;
    notifyListeners();
  }

  delete(String id){
    CartRepositry.deleteFromCart(id);
    notifyListeners();
  }

  void addToCart({required CartModel item})async {

    CartRepositry.addToCart(item: item);

    notifyListeners();
  }

  fetchItems({required userId}) async{
    userId = await AuthenticationsRepostry.getUserIdFromPrefs();
    _items = await CartRepositry.fetchCartItems(userID: userId );

    notifyListeners();
  }




}
