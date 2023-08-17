
import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationsRepostry{
 static SupabaseClient supabaseClient = SupabaseCredentials.supabaseClient;

  static createNewCustomer() async{
    final AuthResponse res = await supabaseClient.auth.signUp(
      email: 'example@email.com',
      password: 'example-password',
      data: {'username': 'my_user_name'},
    );
    final Session? session = res.session;
    final User? user = res.user;
  }


}