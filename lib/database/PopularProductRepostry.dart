
import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/models/ProductModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PopularProductRepostry{
 static SupabaseClient supabaseClient = SupabaseCredentials.supabaseClient;
  static var length;

  static Future<List<ProductModel>> fetchPopularProduct(int start,int end)async{
    try{
      final response = await supabaseClient.from('products')
          .select().range(start, end).execute();

      List<ProductModel> products = (response.data as List)
      .map((e) => ProductModel.fromJson(e)).toList();

      return products;

    }catch(e){
      print('Error when fetching Popular Products: $e');
      return [];
    }
  }

 static fetchPopularProductLength()async{
    final response = await supabaseClient.from('products').select().execute();
    List<ProductModel> products = (response.data as List)
        .map((e) => ProductModel.fromJson(e)).toList();

    length = products.length;
  }

}