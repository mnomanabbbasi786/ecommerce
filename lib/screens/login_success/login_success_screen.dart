import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatefulWidget {
  static String routeName = "/login_success";

  @override
  _LoginSuccessScreenState createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  @override
  void initState() {
    super.initState();
    _setSeen();
  }

  _setSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Login Success"),
      ),
      body: Body(),
    );
  }
}
