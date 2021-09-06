
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key ?key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            decoration: InputDecoration(

              contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("assets/Image.png"),
      ),
    );
  }
}
