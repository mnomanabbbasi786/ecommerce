
import 'package:ecommerce/credentials/SupabaseClient.dart';
import 'package:ecommerce/models/ProductModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularProductRepostry{
 static SupabaseClient supabaseClient = MySupabaseClient.supabaseClient;
  static var length;

  static Future<List<ProductModel>> fetchProduct({required int start,required int end,required String categoryName})async{
    try{
      final response = await supabaseClient.from('products')
          .select().eq('category_name', categoryName).range(start, end).execute();

      List<ProductModel> products = (response.data as List)
      .map((e) => ProductModel.fromJson(e)).toList();

      return products;

    }catch(e){
      print('Error when fetching Popular Products: $e');
      return [];
    }
  }

 static Future<int> fetchProductLength({required String categoryName})async{
    final response = await supabaseClient.from('products').select().eq('category_name', categoryName).execute();
    List<ProductModel> products = (response.data as List)
        .map((e) => ProductModel.fromJson(e)).toList();
      return products.length;
  }

}