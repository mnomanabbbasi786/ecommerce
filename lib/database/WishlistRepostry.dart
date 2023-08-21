
import 'package:ecommerce/credentials/SupabaseClient.dart';
import 'package:ecommerce/database/AuthenticationsRepostry.dart';
import 'package:ecommerce/models/WishlistModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class WishlistRepostry{

  static  SupabaseClient supabaseClient =MySupabaseClient.supabaseClient;


  static addToWishList(WishlistModel wishlistModel)async{
    try{

      await supabaseClient.from('Wishlist')
          .insert(wishlistModel).execute();

    }catch(e){
      print('Error when adding product to wishlist: $e');
    }
  }

  static Future<List<WishlistModel>> fetchWishList()async{
    try{
      var _userId = await AuthenticationsRepostry.getUserIdFromPrefs();
          final response = await supabaseClient.from('Wishlist')
              .select().eq('user_id', _userId ).execute();
          List<WishlistModel> wishListItems = (response.data as List)
          .map((e) => WishlistModel.fromJson(e)).toList();
          return wishListItems;
    }catch(e){
      print('Error when fetching wishlist products: $e');
      return[];
    }
  }
  static Future<List<String>> fetchWishListID()async{
    try{
      final response = await supabaseClient.from('Wishlist')
          .select('id').execute();
      List<String> wishListItems = [];
        for(final entry in response.data as List<dynamic>){
          final id = entry['id'].toString();
          wishListItems.add(id);
        }
      return wishListItems;
    }catch(e){
      print('Error when fetching wishlist products Id: $e');
      return[];
    }
  }
  static deleteWishlistItem(String id) async{
    try{
          await supabaseClient.from('Wishlist').delete().eq('id', id).execute();
    }catch(e){
      print('Error when deleting the Wishlist Item: $e');
    }
  }
}