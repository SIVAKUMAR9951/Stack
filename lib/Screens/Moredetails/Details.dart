import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Screens/Category/Book_Category.dart';
import 'dart:convert';

import 'package:stacklibrary/Screens/Moredetails/Mora_Details.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';

class Details extends StatefulWidget {
  final String text;

  Details({Key? key, required this.text}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends StateMVC<Details> {
  String? auth_token;
  String? Detaild_id;
  String? user_id;
  bool visible = false;



  Future<List<dynamic>> BookDetails() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    auth_token = pref.getString("api_login_token")!;
    Detaild_id = pref.getString("Detaild_id")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse(
          "http://stack.kriyaninfotech.com/api/inidividualbooks/userid/bookid"),
      body: data,
    );
    print(result.body);
    return json.decode(result.body)["relatedbooks"];
  }

  Future<List<dynamic>> readingBooks(String text) async {
    print("inidividualbook    " + text);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    auth_token = pref.getString("api_login_token")!;
    Map data = {'token': auth_token};
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/inidividualbooks/" + text),
      body: data,
    );
    print(result.body);
    return json.decode(result.body)["inidividualbook"];
  }

  String inidividualbook_id(dynamic user) {
    if (user['id'] == null) {
      return user['id'] = "9";
    }
    return user['id'].toString();
  }

  String inidividualbook_name(dynamic user) {
    if (user['book_name'] == null) {
      return user['book_name'] = "Null";
    }
    return user['book_name'];
  }

  String inidividualbook_rating(dynamic user) {
    if (user['book_rating'] == null) {
      return user['book_rating'] = "0";
    }
    return user['book_rating'];
  }

  String inidividualbook_coverimage(dynamic user) {
    return user['bookcoverimage'];
  }

  String inidividualbook_author_name(dynamic user) {
    if (user['author_name'] == null) {
      return user['author_name'] = "Null";
    }
    return user['author_name'];
  }

  String inidividualbook_desc(dynamic user) {
    if (user['desc'] == null) {
      return user['desc'] = "Null";
    }
    return user['desc'];
  }

  String inidividualbook_no_of_pages(dynamic user) {
    if (user['no_of_pages'] == null) {
      return user['no_of_pages'] = "Null";
    }
    return user['no_of_pages'];
  }

  String inidividualbook_format(dynamic user) {
    if (user['book_format'] == null) {
      return user['book_format'] = "Null";
    }
    return user['book_format'];
  }

  String inidividualbook_language(dynamic user) {
    if (user['book_language'] == null) {
      return user['book_language'] = "Null";
    }
    return user['book_language'];
  }

  String inidividualbook_publication(dynamic user) {
    if (user['publication'] == null) {
      return user['publication'] = "Null";
    }
    return user['publication'];
  }

  String inidividualbook_publication_date(dynamic user) {
    if (user['book_publication_date'] == null) {
      return user['book_publication_date'] = "Null";
    }
    return user['book_publication_date'];
  }

  String inidividualbook_author_desc(dynamic user) {
    if (user['author_desc'] == null) {
      return user['author_desc'] = "Null";
    }
    return user['author_desc'];
  }

  String inidividualbook_rack_number(dynamic user) {
    if (user['isbn'] == null) {
      return user['isbn'] = "0";
    }
    return user['isbn'];
  }

  String inidividualbook_shelf_number(dynamic user) {
    if (user['isbn'] == null) {
      return user['isbn'] = "0";
    }
    return user['isbn'];
  }

  String inidividualbook_quantity(dynamic user) {
    if (user['quantity'] == null) {
      return user['quantity'] = "0";
    }
    return user['quantity'];
  }

  @override
  void initState() {
    readingBooks(widget.text);
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
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: readingBooks(widget.text),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: new Image.network(
                                                        "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                            inidividualbook_coverimage(
                                                                snapshot.data[
                                                                    index])) ==
                                                    null
                                                ? Image.asset(
                                                    'assets/st_logo.png')
                                                : Image.network(
                                                    "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                        inidividualbook_coverimage(
                                                            snapshot
                                                                .data[index])),
                                            // Image.asset("assets/demo123.png",
                                            //   fit: BoxFit.cover,
                                            // ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                        height: 150,
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 0,
                                                  right: 5,
                                                  bottom: 2),
                                              child: Text(
                                                  inidividualbook_name(
                                                      snapshot.data[index]),
                                                  style: textStyleBold()),
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 2,
                                                  right: 5,
                                                  bottom: 2),
                                              child: Text(
                                                  inidividualbook_author_name(
                                                      snapshot.data[index]),
                                                  style: textStyleItalic()),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(2),
                                              child: Row(
                                                children: [
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: double.parse(
                                                        inidividualbook_rating(
                                                            snapshot
                                                                .data[index])),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.all(5),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        inidividualbook_rating(
                                                            snapshot
                                                                .data[index]),
                                                        style:
                                                            textStyleNormal()),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text("Read",
                                                  style:
                                                      textStyleNormal18black()),
                                            )),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text("Listen",
                                                  style:
                                                      textStyleNormal18black()),
                                            )),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text("watch video",
                                                  style:
                                                      textStyleNormal18black()),
                                            )),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => _addDownloadList(
                                        inidividualbook_id(snapshot.data[index])),
                                    child: Container(
                                      height: 50,
                                      width: 60,
                                      child: Image.asset(
                                        "assets/download.png",
                                        width: 47.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 60,
                                    child: Image.asset(
                                      "assets/save.png",
                                      width: 47.0,
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 60,
                                    child: Image.asset(
                                      "assets/file/re_book.jpeg",
                                      width: 47.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                            ),
                            /*  Container(
                  height: height*0.30,
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
                        width: 150,
                        margin: EdgeInsets.all(2),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
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
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => More_Details()));
                          },
                        child:Container(
                          margin: EdgeInsets.all(2),
                          child: Text("More Details",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue),
                          ),
                        ) ,
                      ),

                      Divider(
                        height: 1,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),*/
                            Container(
                              height: height * 0.45,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            /*Container(
                                              child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  margin: EdgeInsets.all(2),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      "Book Introduction",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
                                              ),
                                            ),*/
                                            /*Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Book Title :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey))),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_name(
                                                                snapshot.data[
                                                                    index]),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black))),
                                                  ],
                                                )),*/
                                            /*    Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Author  Name :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey))),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_author_name(
                                                                snapshot.data[
                                                                    index]),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black))),
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey))),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            "Book Introduction",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black))),
                                                  ],
                                                )),
                                            Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                                "Discription :",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey)))),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_desc(
                                                                snapshot.data[
                                                                    index]),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black))),
                                                  ],
                                                )),*/
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Total Pages :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_no_of_pages(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("Formet :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_format(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Language :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_language(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Publisher :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_publication(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Publication Date  :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_publication_date(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "ISBN Number Date  :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_shelf_number(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Location  :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text("Null",
                                                            // inidividualbook_author_desc(
                                                            //     snapshot.data[
                                                            //         index]),
                                                            style:
                                                                textStyleNormalblack())),
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text(
                                                            "Quantity  :",
                                                            style:
                                                                textStyleNormal())),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            inidividualbook_quantity(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleNormalblack())),
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
                                            margin: EdgeInsets.all(5),
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              alignment: Alignment.centerLeft,
                                              child: Text("Description",
                                                  style: textStyleBold()),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text(
                                                  inidividualbook_desc(
                                                      snapshot.data[index]),
                                                  style:
                                                      textStyleNormal12black())),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text("Read More ",
                                                  style:
                                                      textStyleNormal12blue()))
                                        ],
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
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              alignment: Alignment.centerLeft,
                                              child: Text("About Author",
                                                  style: textStyleBold()),
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text(
                                                  inidividualbook_author_desc(
                                                      snapshot.data[index]),
                                                  style:
                                                      textStyleNormal12black())),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.all(10),
                                              child: Text("Read More ",
                                                  style:
                                                      textStyleNormal12blue()))
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 2,
                                    ),
                                    // Container(
                                    //        margin: EdgeInsets.all(5),
                                    //        alignment: Alignment.centerLeft,
                                    //        child: Text("Related Books",
                                    //            style: TextStyle(
                                    //                fontWeight: FontWeight.bold,
                                    //                fontSize: 18,
                                    //                color: Colors.black)),
                                    //      ),

                                    // Container(
                                    //   child: SingleChildScrollView(
                                    //       child: Container(
                                    //     // width: width * 0.50,
                                    //     height: height * 0.40,
                                    //     child: FutureBuilder<List<dynamic>>(
                                    //       future: readingBooks(),
                                    //       builder: (BuildContext context,
                                    //           AsyncSnapshot snapshot) {
                                    //         if (snapshot.hasData) {
                                    //           return ListView.builder(
                                    //               scrollDirection: Axis.horizontal,
                                    //               itemCount: snapshot.data.length,
                                    //               itemBuilder:
                                    //                   (BuildContext context, int index) {
                                    //                 return Container(
                                    //                   margin: EdgeInsets.all(10),
                                    //                   width: width * 0.45,
                                    //                   height: height * 0.40,
                                    //                   child: Column(
                                    //                     mainAxisAlignment:
                                    //                         MainAxisAlignment.start,
                                    //                     children: [
                                    //                       Container(
                                    //                         height: height * 0.25,
                                    //                         child: Card(
                                    //                             clipBehavior:
                                    //                                 Clip.antiAlias,
                                    //                             shape:
                                    //                                 RoundedRectangleBorder(
                                    //                               borderRadius:
                                    //                                   BorderRadius.circular(
                                    //                                       10.0),
                                    //                             ),
                                    //                             child: ClipRRect(
                                    //                               borderRadius:
                                    //                                   BorderRadius.circular(
                                    //                                       10.0),
                                    //                               child: new Image.network(
                                    //                                   "http://stack.kriyaninfotech.com/public/coverimages/" +
                                    //                                       reading_bookcover_image(
                                    //                                           snapshot.data[
                                    //                                               index])),
                                    //                               // Image.asset("assets/demo123.png",
                                    //                               //   fit: BoxFit.cover,
                                    //                               // ),
                                    //                             )),
                                    //                       ),
                                    //                       Container(
                                    //                         margin: EdgeInsets.only(
                                    //                             left: 5,
                                    //                             top: 2,
                                    //                             right: 5,
                                    //                             bottom: 2),
                                    //                         alignment: Alignment.centerLeft,
                                    //                         child: Text(
                                    //                             reading_book_name(
                                    //                                 snapshot.data[index]),
                                    //                             style: TextStyle(
                                    //                                 fontWeight:
                                    //                                     FontWeight.bold,
                                    //                                 fontSize: 14,
                                    //                                 color: Colors.black),
                                    //                             overflow:
                                    //                                 TextOverflow.ellipsis),
                                    //                       ),
                                    //                       Container(
                                    //                         margin: EdgeInsets.only(
                                    //                             left: 5,
                                    //                             top: 2,
                                    //                             right: 5,
                                    //                             bottom: 2),
                                    //                         alignment: Alignment.centerLeft,
                                    //                         child: Text(
                                    //                             reading_author_name(
                                    //                                 snapshot.data[index]),
                                    //                             style: TextStyle(
                                    //                                 fontWeight:
                                    //                                     FontWeight.bold,
                                    //                                 fontSize: 12,
                                    //                                 color: Colors.black),
                                    //                             overflow:
                                    //                                 TextOverflow.ellipsis),
                                    //                       ),
                                    //                       Container(
                                    //                         margin: EdgeInsets.all(2),
                                    //                         child: Row(
                                    //                           children: [
                                    //                             Expanded(
                                    //                               flex: 3,
                                    //                               child: RatingBar.builder(
                                    //                                 itemSize: 15,
                                    //                                 initialRating: double.parse(
                                    //                                     reading_book_rating(
                                    //                                         snapshot.data[
                                    //                                             index])),
                                    //                                 minRating: 1,
                                    //                                 direction:
                                    //                                     Axis.horizontal,
                                    //                                 allowHalfRating: true,
                                    //                                 itemCount: 5,
                                    //                                 itemPadding: EdgeInsets
                                    //                                     .symmetric(
                                    //                                         horizontal:
                                    //                                             4.0),
                                    //                                 itemBuilder:
                                    //                                     (context, _) =>
                                    //                                         Icon(
                                    //                                   Icons.star,
                                    //                                   color: Colors.amber,
                                    //                                 ),
                                    //                                 onRatingUpdate:
                                    //                                     (rating) {
                                    //                                   print(rating);
                                    //                                 },
                                    //                               ),
                                    //                             ),
                                    //                             Expanded(
                                    //                                 flex: 1,
                                    //                                 child: Container(
                                    //                                   margin:
                                    //                                       EdgeInsets.all(5),
                                    //                                   alignment: Alignment
                                    //                                       .centerRight,
                                    //                                   child: Text(
                                    //                                       reading_book_rating(
                                    //                                           snapshot.data[
                                    //                                               index]),
                                    //                                       style: TextStyle(
                                    //                                           fontWeight:
                                    //                                               FontWeight
                                    //                                                   .bold,
                                    //                                           fontSize: 12,
                                    //                                           color: Colors
                                    //                                               .black)),
                                    //                                 ))
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 );
                                    //                 /* Container(
                                    //               child: Column(
                                    //                 children: [
                                    //                   Card(child: Text(
                                    //                       _name(snapshot.data[index]) +
                                    //                           _name(
                                    //                               snapshot.data[index])),),
                                    //                   Card(child: Text(
                                    //                       _name(snapshot.data[index]) +
                                    //                           _name(
                                    //                               snapshot.data[index])),),
                                    //                   Card(child: Text(
                                    //                       _name(snapshot.data[index])),)
                                    //                 ],
                                    //               )
                                    //
                                    //           )*/
                                    //                 // ListTile(
                                    //                 //   title: Text(_age(snapshot.data[index])),
                                    //                 //   subtitle: Text(_location(snapshot.data[index])),
                                    //                 //   trailing: Text(_age(snapshot.data[index])),
                                    //                 // )
                                    //                 ;
                                    //               });
                                    //         } else {
                                    //           return Center(
                                    //               child: CircularProgressIndicator());
                                    //         }
                                    //       },
                                    //     ),
                                    //   )),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                    /* Container(
                                      child: Column(
                                        children: [
                                          Card(child: Text(
                                              _name(snapshot.data[index]) +
                                                  _name(
                                                      snapshot.data[index])),),
                                          Card(child: Text(
                                              _name(snapshot.data[index]) +
                                                  _name(
                                                      snapshot.data[index])),),
                                          Card(child: Text(
                                              _name(snapshot.data[index])),)
                                        ],
                                      )

                                  )*/
                    // ListTile(
                    //   title: Text(_age(snapshot.data[index])),
                    //   subtitle: Text(_location(snapshot.data[index])),
                    //   trailing: Text(_age(snapshot.data[index])),
                    // )
                    ;
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
  _addDownloadList(String book_id) async {
    setState(() {
      visible = true;
    });

    final SharedPreferences pref = await SharedPreferences.getInstance();
    auth_token = pref.getString("api_login_token")!;
    user_id = pref.getString("id").toString();
    String vals = "http://stack.kriyaninfotech.com/api/downloadpdf/" +
        user_id! +
        "/" +
        book_id;
    print(vals);

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse(vals),
      body: data,
    );
    print(result.body);
    print(result.statusCode);
    if(result.statusCode==201){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,
          content: Text('Record Add Download List Successfully',style: textStyleBoldwhite(),)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
          content: Text('Recordd not Add Download List',style: textStyleBoldwhite(),)));
    }
  }
}
