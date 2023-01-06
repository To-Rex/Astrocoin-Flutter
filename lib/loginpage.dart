import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:astro_coin/password_page.dart';
import 'package:astro_coin/samplepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'companent/receiver_page.dart';
import 'companent/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  var token = '';
  var password = '';
  var error = Colors.black;

  Future<void> login() async {
    final response = await http.post(
      Uri.parse("https://api.astrocoin.uz/api/login"),
      body: {
        'email': _email.text,
        'password': _password.text,
      },
    );
    if (response.statusCode == 200) {
      var token = json.decode(response.body)['token'] ?? '';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const SamplePage();
        }));
      }
      if (Platform.isAndroid || Platform.isIOS) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const PasswordScreenPage();
        }));
      }
    } else {
      error = Colors.red;
      setState(() {
      });
      Timer(const Duration(seconds: 1), () {
        error = Colors.black;
        _password.clear();
        setState(() {
        });
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/loginimages.png'),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(241, 241, 241, 100),
                border: Border.all(
                    color: const Color.fromRGBO(241, 241, 241, 100), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                cursorColor: Colors.deepPurpleAccent,
                controller: _email,
                textAlign: TextAlign.left,
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  color: error,
                  fontWeight: FontWeight.w400,
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle: GoogleFonts.fredoka(
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(241, 241, 241, 100),
                border: Border.all(
                    color: const Color.fromRGBO(241, 241, 241, 100), width: 0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLength: 15,
                minLines: 1,
                maxLines: 1,
                controller: _password,
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  color: error,
                  fontWeight: FontWeight.w400,
                ),
                textInputAction: TextInputAction.next,
                obscureText: true,
                toolbarOptions: const ToolbarOptions(
                  cut: false,
                  copy: false,
                  selectAll: false,
                  paste: false,
                ),
                decoration: const InputDecoration(
                  counter: Offstage(),
                  hintText: 'Password',
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context)
                            .size
                            .height *
                            0.9,
                        width: MediaQuery.of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight:
                            Radius.circular(10),
                          ),
                        ),
                        child: ReceiverPage(),
                      ));
                },
                child: Text(
                  'Receiver',
                  style: GoogleFonts.fredoka(
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 20,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            children: [
              const Expanded(child: Text('')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(87, 51, 209, 180),
                    border: Border.all(
                        color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: true,
                          enableDrag: false,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.9,
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight:
                                Radius.circular(10),
                              ),
                            ),
                            child: SiginUpPage(),
                          ));
                    },
                    child: Text(
                      '  Sign Up  ',
                      style: GoogleFonts.fredoka(
                        fontSize: 20,
                        color: const Color.fromRGBO(87, 51, 209, 10),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: Text('')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(87, 51, 209, 20),
                    border: Border.all(
                        color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_email.text.isEmpty ){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your email'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            duration: Duration(milliseconds: 1700),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      if (_password.text.isEmpty ){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your password'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            duration: Duration(milliseconds: 1700),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      login();
                    },
                    child: Text(
                      '   Sign In   ',
                      style: GoogleFonts.fredoka(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: Text('')),
            ],
          )
        ],
      ),
    );
  }
}
