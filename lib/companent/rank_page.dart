import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class rankPage extends StatefulWidget {
  rankPage({ Key? key}) : super(key: key);
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<rankPage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: const Color.fromRGBO(241, 241, 241, 10),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.close),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: const WebView(
                        initialUrl: 'https://astrocoin.uz/ranks',
                        javascriptMode: JavascriptMode.unrestricted,
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