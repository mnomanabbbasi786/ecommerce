import 'package:ecommerce/credentials/credentails_auth.dart';
import 'package:ecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/fluttertoat.dart';
import '../helper/keyboard.dart';
import '../screens/login_success/login_success_screen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationsRepostry {
  static SupabaseClient supabaseClient = SupabaseCredentials.supabaseClient;

  static Future<void> createNewCustomer(
      {required String email, required String password}) async {
    try {
      final AuthResponse res = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      if (res.user != null) {
        print('Account created successfully! User ID: ${res.user!.id}');
        await _storeUserIdInPrefs(
            res.user!.id); // Storing user ID in shared prefs.
      } else {
        print('Sign up failed. ${res.session}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  static signInUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      final AuthResponse res = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        print('SignIn successful');
        await _storeUserIdInPrefs(
            res.user!.id); // Storing user ID in shared prefs.
        ToastUtil.showCustomToast(
            message: 'SignIn successful',
            iconData: Icons.person,
            context: context);
        KeyboardUtil.hideKeyboard(context);
        Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      } else {
        print('Sign in failed. ${res.session}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  // Function to store the user ID in shared preferences.
  static Future<void> _storeUserIdInPrefs(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // Function to get the user ID from shared preferences.
  static Future<String?> getUserIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Function to clear the user ID from shared preferences.
  static Future<void> _clearUserIdFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

// Method to logout the user
  static Future<void> logout(BuildContext context) async {
    // 1. Clear the user ID from shared preferences
    await _clearUserIdFromPrefs();

    // 2. Logout from Supabase
    await supabaseClient.auth.signOut();

    // 3. Redirect to the login screen
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context,
        SignInScreen.routeName); // Assuming /login is your login screen route
  }
}
