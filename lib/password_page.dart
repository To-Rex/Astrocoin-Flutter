import 'dart:async';

import 'package:astro_coin/samplepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PasswordScreenPage extends StatefulWidget {
  const PasswordScreenPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordScreenPage> {
  var one = Colors.white;
  var two = Colors.white;
  var three = Colors.white;
  var four = Colors.white;

  var token = "";
  var index = 0;
  var index1 = 0;
  var included = '';
  var password = '';
  var pass = '';
  var textism = 'Guest';
  var txtPasswordName = 'Enter Password';

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    password = prefs.getString('password') ?? '';
    if(prefs.getString('name') != null){
      textism = prefs.getString('name') ?? '';
    }else{
      textism = 'Guest';
    }
    if (password.isNotEmpty) {
      txtPasswordName = 'Enter Password';
    } else {
      txtPasswordName = 'Create Password';
    }
    setState(() {});
  }

  void _onback() {
    included = included.substring(0, index);
    if (index == -1) {
      index++;
    }
    if (index == 0) {
      one = Colors.white;
    }
    if (index == 1) {
      two = Colors.white;
    }
    if (index == 2) {
      three = Colors.white;
    }
    if (index == 3) {
      four = Colors.white;
    }
    if (index > 4) {
      index == 4;
    }
  }

  Future<void> _onclick() async {
    if (index == 1) {
      one = Colors.black;
    }
    if (index == 2) {
      two = Colors.black;
    }
    if (index == 3) {
      three = Colors.black;
    }
    if (index == 4) {
      four = Colors.black;
      if(password.isNotEmpty){
        //enter password
        if(password == included){
          one = Colors.deepPurpleAccent;
          two = Colors.deepPurpleAccent;
          three = Colors.deepPurpleAccent;
          four = Colors.deepPurpleAccent;
          _soucsess();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const SamplePage();
        }));
        }
        else{
          included = '';
          index = 0;
          one = Colors.red;
          two = Colors.red;
          three = Colors.red;
          four = Colors.red;
          _foults();
        }
      }
      else{
        //create password
        if(index1 == 1){
          if(pass==included){
            one = Colors.deepPurpleAccent;
            two = Colors.deepPurpleAccent;
            three = Colors.deepPurpleAccent;
            four = Colors.deepPurpleAccent;
            _soucsess();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('password', included);
            included = '';
            index = 0;
            index1 = 0;
            pass = '';
            txtPasswordName = 'Enter Password';
            getData();
          }
          else{
            included = '';
            index = 0;
            one = Colors.red;
            two = Colors.red;
            three = Colors.red;
            four = Colors.red;
            _foults();
          }
        }
        if(index1==0){
          index1++;
          pass = included;
          included = '';
          index = 0;
          one = Colors.deepPurpleAccent;
          two = Colors.deepPurpleAccent;
          three = Colors.deepPurpleAccent;
          four = Colors.deepPurpleAccent;
          _soucsess();
          txtPasswordName = 'Confirm Password';
        }
      }
    }
    if (index > 4) {
      index = 4;
    }
  }

  void _foults() {
    Timer(const Duration(milliseconds: 600), () {
      one = Colors.white;
      two = Colors.white;
      three = Colors.white;
      four = Colors.white;
      included = '';
      index = 0;
      setState(() {});
    });
  }

  void _soucsess() {
    Timer(const Duration(milliseconds: 600), () {
      one = Colors.white;
      two = Colors.white;
      three = Colors.white;
      four = Colors.white;
      included = '';
      index = 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          SvgPicture.asset(
            'assets/svgs/valletimg.svg',
            height: 40,
            width: 40,
          ),
          Text('Hello, $textism',
            style: GoogleFonts.fredoka(
                color: const Color.fromRGBO(0, 0, 0, 10),
                fontSize: 30, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(txtPasswordName,
              style: GoogleFonts.fredoka(
                  color: const Color.fromRGBO(0, 0, 0, 10),
                  fontSize: 18, fontWeight: FontWeight.w400)),
          Expanded(child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('')),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.06,
                            decoration: BoxDecoration(
                              color: one,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.06,
                            decoration: BoxDecoration(
                              color: two,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.06,
                            decoration: BoxDecoration(
                              color: three,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            width: MediaQuery.of(context).size.width * 0.06,
                            decoration: BoxDecoration(
                              color: four,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('')),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}1';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '1',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}2';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '2',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}3';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '3',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('')),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}4';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '4',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}5';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '5',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}6';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '6',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('')),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}7';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '7',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}8';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '8',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}9';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '9',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('')),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.fingerprint,
                              color: Colors.black,
                              size: 20,
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              included = '${included}0';
                              index++;
                              _onclick();
                              setState(() {});
                            },
                            child: Text(
                              '0',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      //backspace
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (index == 0) {
                                index++;
                              }
                              index--;
                              _onback();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                      ),
                      const Expanded(child: Text('')),
                    ],
                  ),
                ],
              )
            ],
          ),
          ),
        ],
      ),
    );
  }
}