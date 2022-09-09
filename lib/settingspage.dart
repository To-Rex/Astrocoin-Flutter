import 'dart:convert';
import 'dart:io';
import 'package:astro_coin/companent/rank_page.dart';
import 'package:astro_coin/companent/store_page.dart';
import 'package:astro_coin/companent/updateAppPass_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'companent/changePass_page.dart';
import 'loginpage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var token = '';
  var name = '';
  var lastname = '';
  var qwasar = '';
  var email = '';
  var number = '';
  var stack = '';
  var role = '';
  var status = '';
  var verify = 0;
  var photo = '';
  var balance = 0;
  var wallet = '';
  var size = 0.0;
  var sizeweight = 0.0;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? ''.trim();
    name = prefs.getString('name') ?? '';
    lastname = prefs.getString('lastname') ?? '';
    qwasar = prefs.getString('qwasar') ?? '';
    email = prefs.getString('email') ?? '';
    number = prefs.getString('number') ?? '';
    stack = prefs.getString('stack') ?? '';
    role = prefs.getString('role') ?? '';
    status = prefs.getString('status') ?? '';
    verify = prefs.getInt('verify') ?? 0;
    photo = prefs.getString('photo') ?? '';
    balance = prefs.getInt('balance') ?? 0;
    wallet = prefs.getString('wallet') ?? '';
    print(verify);
    setState(() {
      final size1 = MediaQuery.of(context).size;
      size = size1.height;
      sizeweight = size1.width;
    });
  }

  void customFullScreenDialog(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return Material(
          color: Colors.black,
          child: InkWell(
            //needed
            onTap: () => Navigator.pop(context),
            child: PhotoView(
              backgroundDecoration: const BoxDecoration(color: Colors.transparent),
              imageProvider: //NetworkImage user image
                  NetworkImage('https://api.astrocoin.uz/$photo'),
            ),
          ),
        );
      },
    ));
  }

  void showImageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Choose an option',style: GoogleFonts.fredoka(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text('Camera', style: GoogleFonts.fredoka(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: Text('Gallery', style: GoogleFonts.fredoka(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),
                  onTap: () {
                    _getFromGallarey();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  late File _image;

  void _getFromCamera() {
    ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((PickedFile? image) {
      if (image != null) {
        setState(() {
          _image = File(image.path);
          cropImage();
        });
      }
    });
  }

  void _getFromGallarey() {
    if (Platform.isAndroid) {
      ImagePicker()
          .getImage(source: ImageSource.gallery)
          .then((PickedFile? image) {
        if (image != null) {
          setState(() {
            _image = File(image.path);
            cropImage();
          });
        }
      });
    }
    if (Platform.isIOS) {
      ImagePicker()
          .getImage(source: ImageSource.gallery)
          .then((PickedFile? image) {
        if (image != null) {
          setState(() {
            _image = File(image.path);
            cropImage();
          });
        }
      });
    }
    if (Platform.isMacOS) {
      ImagePicker()
          .getImage(source: ImageSource.gallery)
          .then((PickedFile? image) {
        if (image != null) {
          setState(() {
            _image = File(image.path);
            cropImage();
          });
        }
      });
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _image = File(croppedFile.path);
        uploadImage();
      });
    }
  }

  Future<void> uploadImage() async {
    getToken();
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.astrocoin.uz/api/user/photo'));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.files.add(await http.MultipartFile.fromPath('photo', _image.path));
    var res = await request.send();
    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('photo');
      prefs.setString('photo', 'https://api.astrocoin.uz/${_image.path}');
      setState(() {
        photo = _image.path;
        getToken();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size * 0.05,
        ),
        Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  customFullScreenDialog(
                      context,
                      PhotoView(
                        imageProvider:
                            NetworkImage('https://api.astrocoin.uz/$photo'),
                      ));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width * 0.16,
                  backgroundImage:
                      NetworkImage('https://api.astrocoin.uz/$photo'),
                ),
              ),
              Positioned(
                bottom: -10,
                right: -3,
                child: Center(
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/svgs/camweb.svg',
                    ),
                    onPressed: () {
                      showImageDialog(context);
                      //uploadImage();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size * 0.005,
        ),
        Row(
          children: [
            const Expanded(child: Text('')),
            Text(
              '$name $lastname',
              style: GoogleFonts.fredoka(
                fontSize: size * 0.029,
                color: Colors.black,
              ),
            ),SizedBox(width: size * 0.01,),
            if(verify == 1)
              Icon(
                Icons.verified,
                color: Colors.deepPurpleAccent,
                size: size * 0.030,
              ),
            const Expanded(child: Text('')),
          ],
        ),
        SizedBox(
          height: size * 0.0009,
        ),
        Text(
          email,
          style: GoogleFonts.fredoka(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: size * 0.005,
        ),
        SizedBox(
          height: size / 1.7,
          child: ListView(
            children: [
              Center(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: sizeweight - 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: sizeweight * 0.04,
                              ),
                              SvgPicture.asset(
                                'assets/svgs/iconrank.svg',
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
                                                0.8,
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
                                            child: rankPage(),
                                          ));
                                },
                                child: Text(
                                  'Student Ranks',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size * 0.012,
                      ),
                      Container(
                        width: sizeweight - 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: sizeweight * 0.04,
                              ),
                              SvgPicture.asset(
                                'assets/svgs/iconstore.svg',
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
                                                0.8,
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
                                            child: storePage(),
                                          ));
                                },
                                child:  Text(
                                  'Astrum Store',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Wrap(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/usersec.svg',
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      qwasar,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1000,
                                child: const Divider(
                                  thickness: 2,
                                  color: Color.fromRGBO(241, 241, 241, 10),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/stackicon.svg',
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      stack,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  //const Expanded(child: Text("")),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1000,
                                child: const Divider(
                                  //height: 20,
                                  thickness: 2,
                                  //indent: 20,
                                  //endIndent: 0,
                                  color: Color.fromRGBO(241, 241, 241, 10),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/cashback.svg',
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: wallet));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        content: Text('Copied to Clipboard'),
                                      ));
                                    },
                                    child: Text(
                                      wallet,
                                      style: GoogleFonts.fredoka(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Wrap(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    SvgPicture.asset(
                                      'assets/svgs/chpass.svg',
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            //enableDrag: false,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) =>
                                                Container(height: MediaQuery.of(context).size.height * 0.8,
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: const BoxDecoration(
                                                    color: Color.fromRGBO(241, 241, 241, 10),
                                                    borderRadius: BorderRadius.only(topLeft:
                                                          Radius.circular(10), topRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: changePassPage(),
                                                ));
                                      },
                                      child:  Text(
                                        'Change Password',
                                        style: GoogleFonts.fredoka(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1000,
                                  child: const Divider(
                                    thickness: 2,
                                    color: Color.fromRGBO(241, 241, 241, 10),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.04,
                                    ),
                                    SvgPicture.asset(
                                      'assets/svgs/apass.svg',
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          isDismissible: true,
                                          //enableDrag: false,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              const AppPassCode(),
                                        );
                                      },
                                      child: Text(
                                        'App Password',
                                        style: GoogleFonts.fredoka(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.012,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              SvgPicture.asset(
                                'assets/svgs/logout.svg',
                              ),
                              TextButton(
                                onPressed: () {
                                  logout();
                                },
                                child: Text(
                                  'Log Out',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

/*Wrap(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            ],
          ),

          ),
        ],
      );*/
  Future<void> logout() async {
    getToken();
    final response = await http
        .post(Uri.parse('https://api.astrocoin.uz/api/logout'), headers: {
      'Authorization': 'Bearer $token',
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Encoding.getByName("utf-8");
    if (response.statusCode == 200) {
      prefs.remove('token');
      prefs.remove('name');
      prefs.remove('lastname');
      prefs.remove('qwasar');
      prefs.remove('email');
      prefs.remove('number');
      prefs.remove('stack');
      prefs.remove('role');
      prefs.remove('status');
      prefs.remove('photo');
      prefs.remove('balance');
      prefs.remove('wallet');
      prefs.setString('password', '');
      prefs.remove('password');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }else{
      prefs.setString('token', '');
      prefs.setString('name', '');
      prefs.setString('lastname', '');
      prefs.setString('qwasar', '');
      prefs.setString('email', '');
      prefs.setString('number', '');
      prefs.setString('stack', '');
      prefs.setString('role', '');
      prefs.setString('status', '');
      prefs.setString('photo', '');
      prefs.setString('balance', '');
      prefs.setString('wallet', '');
      prefs.setString('password', '');
      prefs.remove('password');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);
    }
  }
}
