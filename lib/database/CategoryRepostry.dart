

import 'package:ecommerce/credentials/SupabaseClient.dart';
import 'package:ecommerce/models/CategoryModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepostry{

          static  SupabaseClient supabaseClient = MySupabaseClient.supabaseClient;

          static Future<List<CategoryModel>> fetchCategory() async{
            try{
              final response = await supabaseClient.from('categories')
                  .select().execute();
              List<CategoryModel> categoryList = (response.data as List)
                  .map((e) => CategoryModel.fromJson(e)).toList();
              return categoryList;
            }catch(e){
              print('error when fetching category: $e');
              return [];
            }

          }


}
