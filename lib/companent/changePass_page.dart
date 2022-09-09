import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class changePassPage extends StatefulWidget {
  changePassPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<changePassPage> {
  late final TextEditingController _password = TextEditingController();
  late final TextEditingController _password1 = TextEditingController();
  late final TextEditingController _password2 = TextEditingController();

  var token = '';
  var password = '';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    password = prefs.getString('password') ?? '';
    print(token);
    print(password);
  }

  Future<void> changePass() async {
    final response = await http.post(
      Uri.parse("https://api.astrocoin.uz/api/user/password"),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'old_password': _password.text.trim().toString(),
        'password': _password1.text.trim().toString(),
        'password_confirmation': _password2.text.trim().toString(),
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getToken();
  }
  @override
  void dispose() {
    _password.dispose();
    _password1.dispose();
    _password2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Wrap(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    SvgPicture.asset(
                      'assets/svgs/valletimg.svg',
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                    Text(
                      'Enter new password for your account',
                      style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children:  [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 15,
                        ),
                         Text('Current Password',
                           style: GoogleFonts.fredoka(
                          color: const Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w400,
                        ),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          maxLength: 15,
                          minLines: 1,
                          maxLines: 1,
                          controller: _password,
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            color: Colors.black,
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
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children:  [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 15,
                        ),
                        Text('New password',
                          style: GoogleFonts.fredoka(
                            color: const Color.fromRGBO(0, 0, 0, 0.6),
                            fontWeight: FontWeight.w400,
                          ),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          maxLength: 15,
                          minLines: 1,
                          maxLines: 1,
                          controller: _password1,
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            color: Colors.black,
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
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children:  [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 15,
                        ),
                        Text('Re-enter new password',
                          style: GoogleFonts.fredoka(
                            color: const Color.fromRGBO(0, 0, 0, 0.6),
                            fontWeight: FontWeight.w400,
                          ),),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          maxLength: 15,
                          minLines: 1,
                          maxLines: 1,
                          controller: _password2,
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            color: Colors.black,
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
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_password1.text == _password2.text) {
                              Navigator.pop(context);
                              changePass();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Error in password or password not match'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.fredoka(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
