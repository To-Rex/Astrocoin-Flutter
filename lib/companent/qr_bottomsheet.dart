import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSheet extends StatefulWidget {
   var wallet;
  QrSheet({Key? key, this.wallet}) : super(key: key);

  @override
  _SendSheetState createState() => _SendSheetState();
}

class _SendSheetState extends State<QrSheet> {
  var vallets = '';
  Future<void> customToast(String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  Future<void> getToken() async {
    vallets = widget.wallet.toString();
    setState(() {
    });
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
      children: <Widget>[
         Text('Recieve',
            style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black)),
        SizedBox(
          height: MediaQuery.of(context).size.height / 25,
        ),
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: MediaQuery.of(context).size.height / 2.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3.8 / 2 - 70,
              left: MediaQuery.of(context).size.width / 3.7 - 50,
              child: QrImage(data: vallets, size: 220),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromRGBO(241, 241, 241, 100), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(vallets,
                    style: GoogleFonts.fredoka(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black26)),
                IconButton(
                  icon: const Icon(
                    Icons.content_copy,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: vallets));
                    /*Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text('Wallet id copied to clipboard')));
                    customToast('Wallet id copied to clipboard');*/
                    final snackBar = SnackBar(
                      content: const Text('Yay! A SnackBar!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        //button
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height / 15,
          /*child: RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.deepPurpleAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Close',
              style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),*/
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Close',
              style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
