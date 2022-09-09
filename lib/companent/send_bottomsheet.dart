import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SendSheet extends StatefulWidget {
  var wallet;
  SendSheet({Key? key, this.wallet}) : super(key: key);

  @override
  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<SendSheet> {
  late final _walleta_dress = TextEditingController();
  final _amaund = TextEditingController();
  final _comment = TextEditingController();
  var token = '';
  var fioadress = '-';
  bool _validate = false;
  var wallets = '';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    wallets = widget.wallet;
    _walleta_dress.text = wallets;
    if (widget.wallet.length > 20) {
      checkWallet();
    }
    else{
      _walleta_dress.text = '';
      setState(() {
        fioadress = '-';
      });
    }
  }
  Future<void> checkWallet() async {
    final response = await http.post(
      Uri.parse("https://api.astrocoin.uz/api/wallet"),
      headers: {'Authorization': 'Bearer $token'},
      body: {'address': _walleta_dress.text},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      fioadress = 's';
      _validate = false;
      setState(() {
        fioadress = data['fio'];
      });
    } else {
      fioadress = '-';
      setState(() {
      });
      //print(response.statusCode);
    }
  }
  Future<void> send() async {
    if(_walleta_dress.text.isNotEmpty&&_amaund.text.isNotEmpty) {
      final response = await http.post(
        //headers : {'Authorization': 'Bearer $token'}, body: {'address': _walleta_dress.text}
        Uri.parse("https://api.astrocoin.uz/api/wallet/transfer"),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'wallet_to': _walleta_dress.text.trim(),
          'amount': _amaund.text.trim(),
          'comment': _comment.text,
        },
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      }
    }
    else{
      _amaund.text.isEmpty ? _validate = true : _validate = false;
      setState(() {
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
    _walleta_dress.dispose();
    _amaund.dispose();
    _comment.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         Text("Send", style: GoogleFonts.fredoka(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
         )),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _walleta_dress != '' ? TextEditingController(text: wallets) : _walleta_dress,
              textAlign: TextAlign.left,
              maxLength: 32,
              style: GoogleFonts.fredoka(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(0, 0, 0, 0.5),
              ),
              decoration:  InputDecoration(
                counter: const Offstage(),
                contentPadding: const EdgeInsets.only(left: 10, bottom: 5, top: 20, right: 10),
                border: InputBorder.none,
                hintText: 'wallet address',
                errorText: _validate ? 'Empty' : null,
                hintStyle: GoogleFonts.fredoka(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                ),
                suffixIcon: IconButton(
                  icon: Image.asset('assets/images/pasteicon.png'),
                  onPressed: () {
                    Clipboard.getData('text/plain').then((data) {
                      _walleta_dress.text = data!.text!.trim();
                      //widget.wallet = _walleta_dress.text;
                      wallets = _walleta_dress.text;
                      if (_walleta_dress.text.length > 29) {
                        _walleta_dress.text = _walleta_dress.text;
                        widget.wallet = _walleta_dress.text;
                        checkWallet();
                      }
                    });
                  },
                ),
              ),
              onChanged: (value) {
                if (value.length > 31) {
                  checkWallet();
                }
              },
            ),
          ),
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(fioadress, style: GoogleFonts.fredoka(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            )),
          ),
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _amaund,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.left,
              style: GoogleFonts.fredoka(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10, right: 10),
                border: InputBorder.none,
                hintText: 'O ASC',
                hintStyle: GoogleFonts.fredoka(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
            ),
          ),
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height * 0.213,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                maxLength: 231,
                controller: _comment,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  border: InputBorder.none,
                  hintText: 'Comment',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                onChanged: (value) {
                },
              ),
            ),
          ),
        ),
         SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        //closing button
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height / 15,
          child: RaisedButton(
            onPressed: () {
              send();
              },
            color: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Text('Send',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
