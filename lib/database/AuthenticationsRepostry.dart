
import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/fluttertoat.dart';
import '../helper/keyboard.dart';
import '../screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationsRepostry{
 static SupabaseClient supabaseClient = SupabaseCredentials.supabaseClient;

 static Future<void> createNewCustomer({required String email, required String password}) async {
  try {
     final AuthResponse res = await supabaseClient.auth.signUp(
       email: email,
       password: password,
     );
     final Session? session = res.session;
     final User? user = res.user;


     if (user!.email!.contains(email)) {
       print('Account created successfully! User ID: ${user?.id}');
     } else {

     }

   } catch (e) {
   print('User Already Registered: $e');
   }
 }


  static singInUser(BuildContext context,{required String email, required String password})async{
      try{

        final AuthResponse res = await supabaseClient.auth.signInWithPassword(
          email:email,
          password:password,
        );
        final Session? session = res.session;
        final User? user = res.user;
        if(user!.email!.contains(email)){
          print('SignIn successful');
          ToastUtil.showCustomToast(
              message: 'SignIn successful',
              iconData:Icons.person,
              context: context);
          KeyboardUtil.hideKeyboard(context);
          Navigator.pushNamed(context, LoginSuccessScreen.routeName);
        }else{
          print('your email does not Exits please create an account');
        }

      }catch (e){
        ToastUtil.showCustomToast(
            message: '$e',
            iconData:Icons.person,
            context: context);
        print('Error when Signing an account:$e');
      }
  }


}