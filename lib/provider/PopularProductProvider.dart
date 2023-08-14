
import 'package:ecommerce/database/PopularProductRepostry.dart';
import 'package:flutter/material.dart';
import '../models/ProductModel.dart';

class PopularProductProvider with ChangeNotifier{



  List<ProductModel> productDataa = [];
  int _page = 1;
  int _start = 0;
  int _end = 50;
  bool _isLoading = true;
  int _length=0;
  List<ProductModel> _tempProductData = [];
  var hasMoreData = false;
  List<ProductModel> get productData => productDataa;

  bool get isLoading => _isLoading;
  int get start => _start;
  int get end => _end;
  int get length => _length;

  setStart(int e){
    _start =e;
  }
  setEnd(int st){
    _end = st;
  }
  setIsLoading(bool load){
    _isLoading = load;
    notifyListeners();
  }


  fetchPopularProducts() async {
    print("FETCHING DATA");
    print('start:_$_start');
    print('end: $_end');
    var response = await PopularProductRepostry.fetchPopularProduct(_start, _end);
    productDataa.addAll(response);
    print('data length: ${productDataa.length}');
    _isLoading = false;
    print(productDataa);
    notifyListeners();
  }

}