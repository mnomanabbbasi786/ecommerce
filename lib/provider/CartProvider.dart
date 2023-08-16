import 'package:ecommerce/database/CartRepositry.dart';
import 'package:ecommerce/models/CartModel.dart';
import 'package:flutter/foundation.dart';



class CartProvider extends ChangeNotifier {
  List<CartModel> _items = [];

  List<CartModel> get items => [..._items];

  int _quantity = 1;

  int get quantity => _quantity;

  setQuantity(int productQuantity){
      _quantity = productQuantity;
    notifyListeners();
  }

  delete(String id){
    CartRepositry.deleteFromCart(id);
    notifyListeners();
  }

  void addToCart(CartModel item)async {

    CartRepositry.addToCart(item);

    notifyListeners();
  }

  fetchItems() async{
    _items = await CartRepositry.fetchCartItems();
    notifyListeners();
  }


// Implement methods for removing items, updating quantities, etc.


}
