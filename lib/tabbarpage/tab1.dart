import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_traansfer.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  var transferlist = [];
  var token;
  var walleti = '';
  var index = 1;

  //shared preferences get token
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    walleti = prefs.getString('wallet') ?? '';
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(
        Uri.parse('https://api.astrocoin.uz/api/transfers?page=$index'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    Encoding.getByName("utf-8");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var key in data.keys) {
        var daaata = key;
        for (var j = 0; j < data[key].length; j++) {
          transferlist.add(TransferList(
            keys: daaata.toString(),
            id: data[key][j]['id'] ?? '',
            wallet_from: data[key][j]['wallet_from'] ?? '',
            wallet_to: data[key][j]['wallet_to'] ?? '',
            fio: data[key][j]['fio'] ?? '',
            amount: data[key][j]['amount'] ?? 0,
            title: data[key][j]['title'] ?? '',
            type: data[key][j]['type'] ?? '',
            comment: data[key][j]['comment'] ?? '',
            status: data[key][j]['status'] ?? '',
            date: data[key][j]['date'].substring(0, 10),
            timestamp: data[key][j]['timestamp'] ?? 0,
          ));
          daaata = '';
        }
        if (response.statusCode == 200) {
          Timer(const Duration(milliseconds: 1500), () {
            index++;
            getData();
          });
        }
      }
      setState(() {
        transferlist = transferlist;
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    for (var i = 0; i < transferlist.length; i++)
                      InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    width: MediaQuery.of(context).size.width,
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
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        SvgPicture.asset(
                                          'assets/svgs/astrum.svg',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color:
                                              Color.fromRGBO(241, 241, 241, 10),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 25, top: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.5,
                                                child: ListView(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        if (transferlist[i]
                                                                    .status ==
                                                                'failed' &&
                                                            transferlist[i]
                                                                    .wallet_to ==
                                                                walleti)
                                                          SvgPicture.asset(
                                                            'assets/svgs/uncertainicon.svg',
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                        if (transferlist[i]
                                                                    .status ==
                                                                'failed' &&
                                                            transferlist[i]
                                                                    .wallet_to !=
                                                                walleti)
                                                          SvgPicture.asset(
                                                            'assets/svgs/feildicon.svg',
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                        if (transferlist[i]
                                                                    .status ==
                                                                'success' &&
                                                            transferlist[i]
                                                                    .wallet_to ==
                                                                walleti)
                                                          SvgPicture.asset(
                                                            'assets/svgs/soucsessicon.svg',
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                        if (transferlist[i]
                                                                    .status ==
                                                                'success' &&
                                                            transferlist[i]
                                                                    .wallet_to !=
                                                                walleti)
                                                          SvgPicture.asset(
                                                            'assets/svgs/feildeicon.svg',
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              transferlist[i]
                                                                  .title,
                                                              style: GoogleFonts
                                                                  .fredoka(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${transferlist[i].amount} ASC',
                                                              style: GoogleFonts.fredoka(
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      1),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Service',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    Text(
                                                      transferlist[i].type,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Date and time',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    Text(
                                                      transferlist[i].date,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Receiver`s name',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    Text(
                                                      transferlist[i].fio,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Receiver`s wallet',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    Text(
                                                      transferlist[i].wallet_to,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Comment',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    if (transferlist[i]
                                                            .comment ==
                                                        '')
                                                      Text(
                                                        'No comment',
                                                        style: GoogleFonts.fredoka(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                0, 0, 0, 1),
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    if (transferlist[i]
                                                            .comment !=
                                                        '')
                                                      Text(
                                                        transferlist[i].comment,
                                                        style: GoogleFonts.fredoka(
                                                            color: const Color
                                                                    .fromRGBO(
                                                                0, 0, 0, 1),
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                    ),
                                                    Text(
                                                      'Status',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 100),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    if (transferlist[i]
                                                            .status ==
                                                        'success')
                                                      Text(
                                                        transferlist[i].status,
                                                        style:
                                                            GoogleFonts.fredoka(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    if (transferlist[i]
                                                            .status ==
                                                        'failed')
                                                      Text(
                                                        transferlist[i].status,
                                                        style:
                                                            GoogleFonts.fredoka(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (transferlist[i].keys.length > 0)
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        transferlist[i].keys,
                                        style: GoogleFonts.fredoka(
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.006),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        241, 241, 241, 100),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            241, 241, 241, 100),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.010),
                                      if (transferlist[i].status == 'failed' &&
                                          transferlist[i].wallet_to == walleti)
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            SvgPicture.asset(
                                              'assets/svgs/uncertainicon.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    transferlist[i].title,
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                                .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    //if transferlist[i] > 0 then + else - and transferlist[i] = 0
                                                    '${transferlist[i].amount} ASC',
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                                .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (transferlist[i].status == 'returned' )
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.01),
                                            SvgPicture.asset(
                                              'assets/svgs/uncertainicon.svg',
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.05,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    transferlist[i].title,
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                  Text(
                                                    //if transferlist[i] > 0 then + else - and transferlist[i] = 0
                                                    '${transferlist[i].amount} ASC',
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                            .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (transferlist[i].status == 'failed' &&
                                          transferlist[i].wallet_to != walleti)
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            SvgPicture.asset(
                                              'assets/svgs/feildicon.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    transferlist[i].title,
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                                .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    //if transferlist[i] > 0 then + else - and transferlist[i] = 0
                                                    '${transferlist[i].amount} ASC',
                                                    style: GoogleFonts.fredoka(
                                                        color: const Color
                                                                .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (transferlist[i].status == 'success' &&
                                          transferlist[i].wallet_to == walleti)
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            SvgPicture.asset(
                                              'assets/svgs/soucsessicon.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      transferlist[i].title,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Text(
                                                      //if transferlist[i] > 0 then + else - and transferlist[i] = 0
                                                      '+${transferlist[i].amount} ASC',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (transferlist[i].status == 'success' &&
                                          transferlist[i].wallet_to != walleti)
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            SvgPicture.asset(
                                              'assets/svgs/feildeicon.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      transferlist[i].title,
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Text(
                                                      //if transferlist[i] > 0 then + else - and transferlist[i] = 0
                                                      '-${transferlist[i].amount} ASC',
                                                      style:
                                                          GoogleFonts.fredoka(
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  0, 0, 0, 1),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.010),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.090),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
