import 'package:ecommerce/database/WishlistRepostry.dart';
import 'package:flutter/widgets.dart';

import '../models/WishlistModel.dart';

class WishListProvider with ChangeNotifier {
  List<String> _selectedItem = [];

  List<WishlistModel> _items = [];

  List<WishlistModel> get items => [..._items];
  List<String> get selectItem => _selectedItem;

  addItem(String id, WishlistModel wishlistModel) async {
    _selectedItem.add(id);
    await WishlistRepostry.addToWishList(wishlistModel);
    print('favourite');
    notifyListeners();

  }

  removeItem(String id) async {
    _selectedItem.remove(id);
    await WishlistRepostry.deleteWishlistItem(id);
    print('favourite');
    notifyListeners();
  }

  fetchWishlistId() async {
    _selectedItem = await WishlistRepostry.fetchWishListID();
    print('${_selectedItem}');
  }

  fetchWishlist() async {
    _items = await WishlistRepostry.fetchWishList();
    print('favourite');
    notifyListeners();
  }
}
