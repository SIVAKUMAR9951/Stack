import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacklibrary/Widgets/AppBar.dart';

class Mydownloadsfiles extends StatefulWidget {
  const Mydownloadsfiles({Key? key}) : super(key: key);

  @override
  _MydownloadsfilesState createState() => _MydownloadsfilesState();
}

class _MydownloadsfilesState extends State<Mydownloadsfiles> {
  String? auth_token;
  String? user_id;

  Future<List<dynamic>> DownloadBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;
    user_id = pref.getString("id")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/alldownloads/" + user_id!),
      body: data,
    );
    print(result.body);
    // var jsonData = json.decode(result.body)["savedbookslist"];

    return json.decode(result.body)['bookpdfdownloads'];
  }


  String book_id(dynamic user) {
    return user['id'];
  }

  String book_name(dynamic user) {
    return user['book_name'];
  }

  String author_name(dynamic user) {
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
  }

  @override
  void initState() {
    super.initState();
    DownloadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(children: [
        Container(

          margin: EdgeInsets.all(5),
          child: FutureBuilder<List<dynamic>>(
            future: DownloadBooks(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return  Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            color: Color(0xFFA3D4F8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child:  Container(

                              child:  Row(
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
                                                  bookcover_image(
                                                      snapshot.data[
                                                      index]),fit: BoxFit.fill,) ==
                                                null
                                                ? Image.asset(
                                                'assets/st_logo.png')
                                                : Image.network(
                                                "http://stack.kriyaninfotech.com/public/coverimages/" +
                                                    bookcover_image(
                                                        snapshot
                                                            .data[index]),fit: BoxFit.fill),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                        height: 150,
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 2,
                                                  right: 5,
                                                  bottom: 2),
                                              child: Text(
                                                  book_name(
                                                      snapshot.data[index]),
                                                  style:textStyleBold(),
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
                                                            author_name(
                                                                snapshot.data[index]),
                                                            style: textStyleItalic(),
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
                                                        book_rating(
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
                                                        book_rating(
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
                                  GestureDetector(
                                    onTap: () =>
                                        deleteBooks(
                                            book_id(
                                                snapshot
                                                    .data[
                                                index])),
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(left: 1,top: 15,right: 10,bottom: 15),
                                      child: Image.asset("assets/file/trash-2.png"),
                                    ),)

                                ],
                              ),
                            ),)

                        ],
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          child: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: Colors.blue,
            heroTag: 1,
            onPressed: () {
              //do something on press
            },
          ),
        )
      ],),

    );
  }
  // 9908759911
  deleteBooks(book_id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;
    user_id = pref.getString("id")!;

    Map data = {'token': auth_token};
    print(auth_token! + "  token3");
    var result = await http.post(
      Uri.parse("http://stack.kriyaninfotech.com/api/deletedownloads/" + user_id!+"/"+book_id),
      body: data,
    );
    print(result.body);
    print(result.statusCode);
    if(result.statusCode==201){
      setState(() {
        DownloadBooks();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,
          content: Text('Record Delete Successfully',style: textStyleBoldwhite(),)));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
          content: Text('Recordd not deleted',style: textStyleBoldwhite(),)));
    }

  }

}
