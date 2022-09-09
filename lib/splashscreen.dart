import 'dart:async';
import 'dart:io';

import 'package:astro_coin/loginpage.dart';
import 'package:astro_coin/password.dart';
import 'package:astro_coin/password_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplshScreen extends StatefulWidget {
  @override
  _SplshScreenState createState() => _SplshScreenState();
}

class _SplshScreenState extends State<SplshScreen> {
  var password = '';
  var token = '';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password') ?? '';
    print(token);
    print(password);
    Timer(const Duration(milliseconds: 2000), () {
      if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }
      if(Platform.isAndroid|| Platform.isIOS){
        if (password != '') {
          print('token and password are not empty');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const PasswordScreenPage();
          }));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return const LoginPage();
          }));
        }
      }
    });

  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SvgPicture.asset(
          'assets/svgs/valletimg.svg',
          height: 60,
          width: 60,
        ),
      ),
    );
  }
}
