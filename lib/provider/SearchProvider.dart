
import 'package:flutter/cupertino.dart';

class SearchProvider with ChangeNotifier{

  String _search ='';

  String get search => _search;

  setSearchValue(String value){
    _search = value;
    notifyListeners();
  }


}