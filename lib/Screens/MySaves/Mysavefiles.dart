import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Screens/Category/Book_Category.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacklibrary/Widgets/AppBar.dart';

class Mysavefiles extends StatefulWidget {
  const Mysavefiles({Key? key}) : super(key: key);

  @override
  _MydownloadsfilesState createState() => _MydownloadsfilesState();
}

class _MydownloadsfilesState extends State<Mysavefiles> {
  String? auth_token;
  String? user_id;

  Future<List<dynamic>> readingBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;
    user_id = pref.getString("id")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/savelist/" + user_id!),
      body: data,
    );
    print(result.body);
    var jsonData = json.decode(result.body)["savedbookslist"];

    return json.decode(result.body)["savedbookslist"];
  }

  String reading_book_id(dynamic user) {
    return user['id'];
  }

  String reading_book_name(dynamic user) {
    return user['book_name'];
  }

  String reading_author_name(dynamic user) {
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
    readingBooks();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      child: FutureBuilder<List<dynamic>>(
        future: readingBooks(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: Color(0xFFA3D4F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 150,
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
                                                          snapshot.data[index]),
                                                  fit: BoxFit.fill,
                                                ) ==
                                                null
                                            ? Image.asset('assets/st_logo.png')
                                            : Image.network(
                                                "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                    reading_bookcover_image(
                                                        snapshot.data[index]),
                                                fit: BoxFit.fill),
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                    height: 150,
                                    alignment: Alignment.topLeft,
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
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
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
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.all(2),
                                          child: Row(
                                            children: [
                                              RatingBar.builder(
                                                itemSize: 15,
                                                initialRating: double.parse(
                                                    reading_book_rating(
                                                        snapshot.data[index])),
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
                                                        snapshot.data[index]),
                                                    style: textStyleNormal()),
                                              )
                                              /*   Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        margin: EdgeInsets.all(5),
                                                        alignment:
                                                        Alignment.centerRight,
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        ),
                                                      ))*/
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 1,
                                              top: 15,
                                              right: 1,
                                              bottom: 15),
                                          child: Image.asset("assets/save.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 1,
                                              top: 15,
                                              right: 1,
                                              bottom: 15),
                                          child: Image.asset(
                                              "assets/download.png"),
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
