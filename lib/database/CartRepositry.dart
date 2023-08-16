

import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/models/CartModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepositry{
  
static  SupabaseClient supabaseClient = SupabaseCredentials.supabaseClient;
  
 static Future<List<CartModel>> fetchCartItems()async{
    try{
          final response = await supabaseClient.from('Cart')
              .select().execute();
          List<CartModel> items = (response.data as List)
          .map((e) => CartModel.fromJson(e)).toList();

          return items;
    }catch(e){
      print('Error when fetching Cart Items: $e');
      return[];
    }
  }

 static addToCart(CartModel item)async{
    try{
        await supabaseClient.from('Cart').insert(item).execute();

    }catch(e){
      print('Error when adding Item to Cart: $e');
    }
  }

  static deleteFromCart(String id)async{
   try{
        await supabaseClient.from('Cart').delete().eq('id', id);
   }catch(e){

   }
  }

}