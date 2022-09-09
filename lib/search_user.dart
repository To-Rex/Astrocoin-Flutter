import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'companent/usersearch.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {

  @override
  Widget build(BuildContext context) {
    return const ComUserSearch();
  }
}