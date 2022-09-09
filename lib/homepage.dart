import 'dart:convert';
import 'dart:io';
import 'package:astro_coin/transferdata.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'companent/qascanner.dart';
import 'companent/qr_bottomsheet.dart';
import 'companent/send_bottomsheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HopHomePageState createState() => _HopHomePageState();
}

class _HopHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var token;
  var wallet;
  var _ammaunt = '0 ASC';
  late TabController tabController;

  //shared preferences get token
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    wallet = prefs.getString('wallet') ?? '';

    getData();
  }

  Future<void> getData() async {
    final response = await http
        .get(Uri.parse("https://api.astrocoin.uz/api/user"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    encoding:
    Encoding.getByName("utf-8");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        _ammaunt = '${data['balance']} ASC';
        wallet = data['wallet'];
      });
      //save shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', data['name']);
      prefs.setString('lastname', data['last_name']);
      prefs.setString('qwasar', data['qwasar']);
      prefs.setString('email', data['email']);
      prefs.setString('number', data['number']);
      prefs.setString('stack', data['stack']);
      prefs.setString('role', data['role']);
      prefs.setString('status', data['status']);
      prefs.setInt('verify', data['verify']);
      prefs.setString('photo', data['photo']);
      prefs.setInt('balance', data['balance']);
      prefs.setString('wallet', data['wallet']);
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Row(
          children: <Widget>[
            Image.asset(
              'assets/images/valletimage.png',
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ],
        ),
        Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 3.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3.8 / 2 - 70,
                left: MediaQuery.of(context).size.width / 3.9 - 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/astracoin.png',
                      height: 60,
                      width:60,
                      scale: 0.1,
                    ),
                     SizedBox(
                      height: MediaQuery.of(context).size.height / 60,
                    ),
                    Text(
                      _ammaunt,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff000000),
                      ),
                    ),
                     SizedBox(
                      height: MediaQuery.of(context).size.height / 65,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            //show bottom sheet
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(241, 241, 241, 20),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                child: QrSheet(wallet: wallet,),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('assets/images/plussample.png'),
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(241, 241, 241, 20),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                child:  SendSheet(wallet: ''),
                              ),
                            );
                          },
                          child: const Image(
                            image: AssetImage('assets/images/sendsample.png'),
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            //if mac os or windows
                            if(Platform.isMacOS||Platform.isWindows){
                              //snackBar error;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('This feature is not available for MacOS'),
                                ),
                              );
                            }else if(Platform.isAndroid){
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.75,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(241, 241, 241, 20),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: const QRViewExample(),
                                ),
                              );
                            }if(Platform.isIOS){
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.75,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(241, 241, 241, 20),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: const QRViewExample(),
                                ),
                              );
                            }
                          },

                          child: const Image(
                            //icon size height and width
                            image: AssetImage('assets/images/scansample.png'),
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.1,
            child: const TabBarPage(),
          ),
        )
      ],
    );
  }
}
