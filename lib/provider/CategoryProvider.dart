

import 'package:ecommerce/database/PopularProductRepostry.dart';
import 'package:ecommerce/models/ProductModel.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{

  int _length =0;
  List<ProductModel> _product =[];

  List<ProductModel>  get product => _product;

  int _tempLength = 0;
  int get tempLength => _tempLength;
  int get length => _length;

  setProduct({required String categoryName,required int start,required int end})async{

    _product =[];
    _tempLength = 0;
      _product = await PopularProductRepostry.fetchProduct(start: start, end: end, categoryName: categoryName);

      _tempLength =  _product.length;

      notifyListeners();
  }

  setLength({required categoryName}) async{

    _length =  await PopularProductRepostry.fetchProductLength(categoryName: categoryName);
    print(_length);
    if(_length>20){
      _length = 20;
    }else{
      _length = _length;
    }
    notifyListeners();
  }

}