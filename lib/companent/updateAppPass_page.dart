
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPassCode extends StatefulWidget {
  const AppPassCode({Key? key}) : super(key: key);

  @override
  _AppPassCode createState() => _AppPassCode();
}

class _AppPassCode extends State<AppPassCode> {
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
  var txtPasswordName = 'Enter Password';

  Future<void> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token')!;
    password = sharedPreferences.getString('password')!;
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
      if(index1 == 2&&pass == included){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('password', included);
        one = Colors.deepPurpleAccent;
        two = Colors.deepPurpleAccent;
        three = Colors.deepPurpleAccent;
        four = Colors.deepPurpleAccent;
        _soucsess();
        Timer(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });

      }else {
        one = Colors.red;
        two = Colors.red;
        three = Colors.red;
        four = Colors.red;
        _soucsess();
      }
      if(index1 == 1){
        one = Colors.deepPurpleAccent;
        two = Colors.deepPurpleAccent;
        three = Colors.deepPurpleAccent;
        four = Colors.deepPurpleAccent;
        _soucsess();
        pass = included;
        index1++;
        included = '';
        index = 0;
        txtPasswordName = 'Re-Enter Password';
      }
      if (index1 == 0 && included == password) {
        one = Colors.deepPurpleAccent;
        two = Colors.deepPurpleAccent;
        three = Colors.deepPurpleAccent;
        four = Colors.deepPurpleAccent;
        index1++;

        txtPasswordName = 'Enter New Password';
        included = '';
        index = 0;
        _soucsess();
      } if(index1 == 0 && included != password) {
        included = '';
        index = 0;
        one = Colors.red;
        two = Colors.red;
        three = Colors.red;
        four = Colors.red;
        _foults();
      }
    }
    if (index > 4) {
      index = 4;
    }
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

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Wrap(
      children: [
        Container(
          height: displayHeight * 0.8,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(232, 236, 242, 8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Expanded(child: Text('')),
                  TextButton(
                    onPressed: () {
                      index = 0;
                      included = '';
                      txtPasswordName = 'Enter Password';
                      one = Colors.white;
                      two = Colors.white;
                      three = Colors.white;
                      four = Colors.white;
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                txtPasswordName,
                style: GoogleFonts.fredoka(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  const Expanded(child: Text("")),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 30,
                        child: Container(
                          decoration:
                              BoxDecoration(color: one, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 30,
                        child: Container(
                          decoration:
                              BoxDecoration(color: two, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              color: three, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              color: four, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: Text("")),
                ],
              ),
              Expanded(
                  child: GridView.count(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    semanticChildCount: 1,
                    padding: EdgeInsets.all(displayWidth * 0.2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {
                            included = '${included}1';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child:  Text('1',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                          )
                      ),
                      TextButton(
                          onPressed: () {
                            included = '${included}2';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('2',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                          )),
                      TextButton(
                          onPressed: () {
                            included = '${included}3';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child:  Text('3',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}4';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child:  Text('4',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}5';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child:  Text('5',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}6';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('6',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}7';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('7',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}8';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('8',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      TextButton(
                          onPressed: () {
                            included = '${included}9';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('9',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.fingerprint,
                            color: Colors.black,
                          )),
                      TextButton(
                          onPressed: () {
                            included = '${included}0';
                            index++;
                            _onclick();
                            setState(() {});
                          },
                          child: Text('0',
                              style: GoogleFonts.fredoka(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                      IconButton(
                          onPressed: () {
                            if (index == 0) {
                              index++;
                            }
                            index--;
                            _onback();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.backspace_outlined,
                            color: Colors.black,
                          )),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
