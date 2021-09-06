
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacklibrary/Screens/Moredetails/Details.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';
class Audio_Category extends StatefulWidget {
  const Audio_Category({Key? key}) : super(key: key);

  @override
  _Audio_Category createState() => _Audio_Category();
}

class _Audio_Category extends StateMVC<Audio_Category> {


  String? auth_token;
  Future<List<dynamic>> readingBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http
        .post(Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/23"),body: data,);
    print(result.body);
    return json.decode(result.body)["relatedbooks"];
  }

  String reading_book_id(dynamic user) {
    return user['id'].toString();
  }
  String reading_book_name(dynamic user) {
    return user['book_name'];
  }

  String reading_author_name(dynamic user) {
    return user['author_name'];
  }

  String reading_book_rating(dynamic user) {
    return user['book_rating'];
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
      body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text("Most Trending Audio Books", style: textStyleBold()),
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
                                                        BorderRadius.circular(5.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(2.0),
                                                        child: new Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
                                                        ) ==
                                                            null
                                                            ? Image.asset(
                                                            'assets/st_logo.png')
                                                            : Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
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
                                                      reading_author_name(
                                                          snapshot.data[index]),
                                                      style: textStyleBold(),
                                                      overflow: TextOverflow.ellipsis),
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
                                                            alignment:
                                                            Alignment.centerLeft,
                                                            child: Text(
                                                                reading_author_name(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleItalic(),
                                                                overflow: TextOverflow
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
                                                          initialRating: double.parse(
                                                              reading_book_rating(
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
                                                                reading_book_rating(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleNormal()),
                                                          ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: GestureDetector(
                                                            // onTap: () =>
                                                            //     _addSaveList(
                                                            //         book_id(snapshot
                                                            //             .data[
                                                            //         index])),
                                                              child: Container(
                                                                margin: EdgeInsets.all(5),
                                                                alignment:
                                                                Alignment.centerRight,
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
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text("Last Week Leasing Audio Books", style: textStyleBold()),
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
                                                        BorderRadius.circular(5.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(2.0),
                                                        child: new Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
                                                        ) ==
                                                            null
                                                            ? Image.asset(
                                                            'assets/st_logo.png')
                                                            : Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
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
                                                      reading_author_name(
                                                          snapshot.data[index]),
                                                      style: textStyleBold(),
                                                      overflow: TextOverflow.ellipsis),
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
                                                            alignment:
                                                            Alignment.centerLeft,
                                                            child: Text(
                                                                reading_author_name(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleItalic(),
                                                                overflow: TextOverflow
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
                                                          initialRating: double.parse(
                                                              reading_book_rating(
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
                                                                reading_book_rating(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleNormal()),
                                                          ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: GestureDetector(
                                                            // onTap: () =>
                                                            //     _addSaveList(
                                                            //         book_id(snapshot
                                                            //             .data[
                                                            //         index])),
                                                              child: Container(
                                                                margin: EdgeInsets.all(5),
                                                                alignment:
                                                                Alignment.centerRight,
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
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text("Saved Audio Books", style: textStyleBold()),
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
                                                        BorderRadius.circular(5.0),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(2.0),
                                                        child: new Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
                                                        ) ==
                                                            null
                                                            ? Image.asset(
                                                            'assets/st_logo.png')
                                                            : Image.network(
                                                          "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                              reading_bookcover_image(
                                                                  snapshot.data[
                                                                  index]),
                                                          fit: BoxFit.fitWidth,
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
                                                      reading_author_name(
                                                          snapshot.data[index]),
                                                      style: textStyleBold(),
                                                      overflow: TextOverflow.ellipsis),
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
                                                            alignment:
                                                            Alignment.centerLeft,
                                                            child: Text(
                                                                reading_author_name(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleItalic(),
                                                                overflow: TextOverflow
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
                                                          initialRating: double.parse(
                                                              reading_book_rating(
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
                                                                reading_book_rating(
                                                                    snapshot
                                                                        .data[index]),
                                                                style:
                                                                textStyleNormal()),
                                                          ),
                                                      Expanded(
                                                          flex: 1,
                                                          child: GestureDetector(
                                                            // onTap: () =>
                                                            //     _addSaveList(
                                                            //         book_id(snapshot
                                                            //             .data[
                                                            //         index])),
                                                              child: Container(
                                                                margin: EdgeInsets.all(5),
                                                                alignment:
                                                                Alignment.centerRight,
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
                margin: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text("Original Additions",
                    style:textStyleBold()),
              ),
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 0),
                  height: height * 0.50,
                  child: FutureBuilder<List<dynamic>>(
                    future: readingBooks(),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.topLeft,
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
                                                            reading_bookcover_image(
                                                                snapshot.data[
                                                                index])) ==
                                                        null
                                                        ? Image.asset(
                                                        'assets/st_logo.png')
                                                        : Image.network(
                                                        "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                            reading_bookcover_image(
                                                                snapshot.data[
                                                                index])),
                                                    // Image.asset("assets/demo123.png",
                                                    //   fit: BoxFit.cover,
                                                    // ),
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
                                                      alignment: Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          left: 5,
                                                          top: 2,
                                                          right: 5,
                                                          bottom: 2),
                                                      child: Text(
                                                          reading_book_name(
                                                              snapshot.data[index]),
                                                          style: textStyleBold(),
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Container(
                                                      alignment: Alignment.topLeft,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child: Container(
                                                                margin:
                                                                EdgeInsets.only(
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
                                                                    style: textStyleItalic(),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                              )),
                                                          // Expanded(
                                                          //     flex: 1,
                                                          //     child: GestureDetector(
                                                          //         // onTap: ()=>_addSaveList(),
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
                                                      alignment: Alignment.topLeft,
                                                      margin: EdgeInsets.all(2),
                                                      child: Row(
                                                        children: [

                                                            RatingBar.builder(
                                                              itemSize: 15,
                                                              initialRating: double.parse(
                                                                  reading_book_rating(
                                                                      snapshot.data[
                                                                      index])),
                                                              minRating: 1,
                                                              direction:
                                                              Axis.horizontal,
                                                              allowHalfRating: true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  4.0),
                                                              itemBuilder:
                                                                  (context, _) =>
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: Colors.amber,
                                                                  ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                         Container(
                                                                margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    reading_book_rating(
                                                                        snapshot.data[
                                                                        index]),
                                                                    style: textStyleNormal())),

                                                          Expanded(
                                                              flex: 1,
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
}
