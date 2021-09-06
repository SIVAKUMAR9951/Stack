import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Screens/Category/Book_Category.dart';
import 'dart:convert';

import 'package:stacklibrary/Screens/Moredetails/Details.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);

  @override
  _All_Category createState() => _All_Category();
}

bool _loaded = false;
var _loadImage = new AssetImage('assets/demo123.jpeg');

class _All_Category extends StateMVC<All> {
  String? auth_token;
  String? user_id;
  bool visible = false;

  _addSaveList(String book_id) async {
    setState(() {
      visible = true;
    });

    final SharedPreferences pref = await SharedPreferences.getInstance();
    auth_token = pref.getString("api_login_token")!;
    user_id = pref.getString("id").toString();
    String vals = "http://stack.kriyaninfotech.com/api/savebook/21/" +
        user_id! +
        "/" +
        book_id;
    print(vals);

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/savebook/21/" +
          user_id! +
          "/" +
          book_id),
      body: data,
    );
    print(result.body);
    setState(() {
      visible = false;
    });
  }

  Future<List<dynamic>> AllVideoBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/25"),
      body: data,
    );
    print(result.body);
    return json.decode(result.body)["relatedbooks"];
  }

  String video_book_id(dynamic user) {
    if (user['id'] == null) {
      return user['id'] = "9";
    }
    return user['id'].toString();
  }

  String video_book_name(dynamic user) {
    if (user['book_name'] == null) {
      return user['book_name'] = "Demmo";
    }
    return user['book_name'];
  }

  String video_author_name(dynamic user) {
    if (user['author_name'] == null) {
      return user['author_name'] = "Demmo";
    }
    return user['author_name'];
  }

  String video_book_rating(dynamic user) {
    if (user['book_rating'] == null) {
      return user['book_rating'] = "0";
    }
    return user['book_rating'];
  }

  String video_bookcover_image(dynamic user) {
    return user['bookcoverimage'];
// 9666106699
  }

  Future<List<dynamic>> AllBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/21"),
      body: data,
    );
    print(result.body);
    return json.decode(result.body)["relatedbooks"];
  }

  String book_id(dynamic user) {
    if (user['id'] == null) {
      return user['id'] = "9";
    }
    return user['id'].toString();
  }

  String book_name(dynamic user) {
    if (user['book_name'] == null) {
      return user['book_name'] = "Demmo";
    }
    return user['book_name'];
  }

  String author_name(dynamic user) {
    if (user['author_name'] == null) {
      return user['author_name'] = "Demmo";
    }
    return user['author_name'];
  }

  String book_rating(dynamic user) {
    if (user['book_rating'] == null) {
      return user['book_rating'] = "0";
    }
    return user['book_rating'];
  }

  String bookcover_image(dynamic user) {
    return user['bookcoverimage'];
// 9666106699
  }

  Future<List<dynamic>> readingBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/23"),
      body: data,
    );
    print(result.body);
    var jsonData = json.decode(result.body)["relatedbooks"];
    // savePref(jsonData['user']['id']);

    return json.decode(result.body)["relatedbooks"];
  }

  String reading_book_id(dynamic user) {
    return user['id'].toString();
  }

  String reading_book_name(dynamic user) {
    if (user['book_name'] == null) {
      return user['book_name'] = "Demmo";
    }
    return user['book_name'];
  }

  String reading_author_name(dynamic user) {
    if (user['author_name'] == null) {
      return user['author_name'] = "Demmo";
    }
    return user['author_name'];
  }

  String reading_book_rating(dynamic user) {
    if (user['book_rating'] == null) {
      return user['book_rating'] = "0";
    }
    return user['book_rating'];
  }

  String reading_bookcover_image(dynamic user) {
    return user['bookcoverimage'];
  }

  @override
  void initState() {
    super.initState();
    // mostTrandingBooks();
    readingBooks();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.topLeft,
                child: Text("Most Trending Books", style: textStyleBold()),
              ),
              Container(
                child: SingleChildScrollView(
                    child: Container(
                  height: height * 0.40,
                  child: FutureBuilder<List<dynamic>>(
                    future: AllBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Details(
                                                text: reading_book_id(
                                                    snapshot.data[index]))));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.all(5),
                                        width: width * 0.48,
                                        height: height * 0.40,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: width * 0.50,
                                              height: height * 0.25,
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    child: new Image.network(
                                                              "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                  bookcover_image(
                                                                      snapshot.data[
                                                                          index]),
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ) ==
                                                            null
                                                        ? Image.asset(
                                                            'assets/st_logo.png')
                                                        : Image.network(
                                                            "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                bookcover_image(
                                                                    snapshot.data[
                                                                        index]),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                    // Image.asset("assets/demo123.png",

                                                    // ),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 2,
                                                  right: 5,
                                                  bottom: 2),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  book_name(
                                                      snapshot.data[index]),
                                                  style: textStyleBold(),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5,
                                                            top: 2,
                                                            right: 5,
                                                            bottom: 2),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            reading_author_name(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleItalic(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      )),
                                                  // Expanded(
                                                  //     flex: 1,
                                                  //     child: GestureDetector(
                                                  //         onTap: ()=>_addSaveList(book_id(
                                                  //             snapshot.data[index])),
                                                  //         child:Container(
                                                  //           margin: EdgeInsets.all(5),
                                                  //           alignment:
                                                  //           Alignment.centerRight,
                                                  //           child:Image.asset("assets/Headphones_blue.png",height:20,width:20,color: Colors.red,),
                                                  //         )))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: double.parse(
                                                        book_rating(snapshot
                                                            .data[index])),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        EdgeInsets.all(2),
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
                                                    margin: EdgeInsets.all(2),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                        book_rating(snapshot
                                                            .data[index]),
                                                        style:
                                                            textStyleNormal()),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                          onTap: () =>
                                                              _addSaveList(
                                                                  book_id(snapshot
                                                                          .data[
                                                                      index])),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    2),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            ),
                                                          )))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.topLeft,
                child:
                    Text("Most Trending Audio Books", style: textStyleBold()),
              ),
              Container(
                child: SingleChildScrollView(
                    child: Container(
                  height: height * 0.40,
                  child: FutureBuilder<List<dynamic>>(
                    future: readingBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Details(
                                                text: reading_book_id(
                                                    snapshot.data[index]))));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.all(5),
                                        width: width * 0.48,
                                        height: height * 0.40,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: width * 0.50,
                                              height: height * 0.25,
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: new Image.network(
                                                              "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                  bookcover_image(
                                                                      snapshot.data[
                                                                          index]),
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ) ==
                                                            null
                                                        ? Image.asset(
                                                            'assets/st_logo.png')
                                                        : Image.network(
                                                            "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                bookcover_image(
                                                                    snapshot.data[
                                                                        index]),
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                    // Image.asset("assets/demo123.png",

                                                    // ),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 2,
                                                  right: 5,
                                                  bottom: 2),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  book_name(
                                                      snapshot.data[index]),
                                                  style: textStyleBold(),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5,
                                                            top: 2,
                                                            right: 5,
                                                            bottom: 2),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            reading_author_name(
                                                                snapshot.data[
                                                                    index]),
                                                            style:
                                                                textStyleItalic(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                      )),
                                                  // Expanded(
                                                  //     flex: 1,
                                                  //     child: GestureDetector(
                                                  //         onTap: ()=>_addSaveList(book_id(
                                                  //             snapshot.data[index])),
                                                  //         child:Container(
                                                  //           margin: EdgeInsets.all(5),
                                                  //           alignment:
                                                  //           Alignment.centerRight,
                                                  //           child:Image.asset("assets/Headphones_blue.png",height:20,width:20,color: Colors.red,),
                                                  //         )))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(2),
                                              child: Row(
                                                children: [
                                                   RatingBar.builder(
                                                      itemSize: 15,
                                                      initialRating:
                                                          double.parse(
                                                              book_rating(
                                                                  snapshot.data[
                                                                      index])),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),

                                                 Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                            book_rating(snapshot
                                                                .data[index]),
                                                            style:
                                                                textStyleNormal()),
                                                      ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: GestureDetector(
                                                          onTap: () =>
                                                              _addSaveList(
                                                                  book_id(snapshot
                                                                          .data[
                                                                      index])),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            ),
                                                          )))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ));
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child:
                    Text("Most Trending Video Books", style: textStyleBold()),
              ),
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                  height: height * 0.50,
                  child: FutureBuilder<List<dynamic>>(
                    future: AllVideoBooks(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Card(
                                                  clipBehavior: Clip.antiAlias,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: new Image.network(
                                                                "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                    video_bookcover_image(
                                                                        snapshot.data[
                                                                            index])) ==
                                                            null
                                                        ? Image.asset(
                                                            'assets/st_logo.png')
                                                        : Image.network(
                                                            "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                                video_bookcover_image(
                                                                    snapshot.data[
                                                                        index])),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                height: 150,
                                                alignment: Alignment.topRight,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          left: 5,
                                                          top: 2,
                                                          right: 5,
                                                          bottom: 2),
                                                      child: Text(
                                                          video_book_name(
                                                              snapshot
                                                                  .data[index]),
                                                          style:
                                                              textStyleBold(),
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 5,
                                                                        top: 2,
                                                                        right:
                                                                            5,
                                                                        bottom:
                                                                            2),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    video_author_name(
                                                                        snapshot.data[
                                                                            index]),
                                                                    style:
                                                                        textStyleItalic(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                              )),
                                                          // Expanded(
                                                          //     flex: 1,
                                                          //     child: GestureDetector(
                                                          //         onTap: ()=>_addSaveList(book_id(
                                                          //             snapshot.data[index])),
                                                          //         child:Container(
                                                          //           margin: EdgeInsets.all(5),
                                                          //           alignment:
                                                          //           Alignment.centerRight,
                                                          //           child:Image.asset("assets/Headphones_blue.png",height:20,width:20,color: Colors.red,),
                                                          //         )))
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.all(2),
                                                      child: Row(
                                                        children: [
                                                          RatingBar
                                                                .builder(
                                                              itemSize: 15,
                                                              initialRating: double.parse(
                                                                  video_book_rating(
                                                                      snapshot.data[
                                                                          index])),
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                          Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    book_rating(
                                                                        snapshot.data[
                                                                            index]),
                                                                    style:
                                                                        textStyleNormal()),
                                                              ),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  savePref(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("Detaild_id", id);
    preferences.commit();
  }
}
