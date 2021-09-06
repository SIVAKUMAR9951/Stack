import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class More_Details extends StatefulWidget {
  const More_Details({Key ?key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<More_Details> {
  String? auth_token;
  Future<List<dynamic>> readingBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http
        .post(Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/21"),body: data,);
    print(result.body);
    return json.decode(result.body)["relatedbooks"];
  }

  String reading_book_name(dynamic user) {
    return user['book_name'];
  }

  String reading_author_name(dynamic user) {
    return user['author_name'];
  }

  String reading_book_rating(dynamic user) {
    return user['no_of_pages'];
  }

  String reading_bookcover_image(dynamic user) {
    return user['bookcoverimage'];
  }

  @override
  void initState() {
    readingBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                    height: height*0.25,
                    width: width*0.60,
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/st_logo.png",
                              width: 100.0,
                            ),
                          ),
                        ))),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text("Siva kumar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text("Siva kumar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.blue)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 200,
                  margin: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: RatingBar.builder(
                          itemSize: 15,
                          initialRating: 3.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.centerRight,
                            child: Text("4.5",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black)),
                          ))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  // width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.menu_book),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset("assets/headphones.png"),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.download_rounded),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset("assets/save.png"),
                      ),
                    ],
                  ),
                ),
               /* Container(
                  margin: EdgeInsets.all(2),
                  child: Text("More Details",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black)),
                ),*/
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Card(
                            color: Colors.white70,
                            child: Container(
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              child: Text("Book Introduction",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Book Title :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Book Introduction",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Author  Name :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Book Introduction",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Genre :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Book Introduction",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Discription :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("Book Introduction",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Total Pages :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Formet :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Language :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Publisher :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Publication Date  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("ISBN Number Date  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("About Author  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Book Format  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Rack Number  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Shelf Number  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text("Quantity  :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                                Expanded(
                                    flex: 2,
                                    child: Text("451",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Card(
                          color: Colors.white70,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: Text("Description",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black)),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Text("Book Introduction"
                              "Book Introduction"
                              "Book Introduction"
                              "Book Introduction"
                              "Book Introduction"
                              "Book Introduction"
                              "Book Introduction"
                              "Book Introduction",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black))),
                    ],
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
