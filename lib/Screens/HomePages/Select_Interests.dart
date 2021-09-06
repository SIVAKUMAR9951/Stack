import 'package:flutter/material.dart';

class Select_Interests extends StatefulWidget {
  const Select_Interests({Key? key}) : super(key: key);

  @override
  _Select_InterestsState createState() => _Select_InterestsState();
}

class _Select_InterestsState extends State<Select_Interests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Select Your Interestes"),
      ),
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
             child: Row(

                children: [

                  // Expanded(flex:5,child: Container(
                  //     margin: EdgeInsets.all(5),
                  //     height: 150,
                  //     width: 150,
                  //     child: Card(
                  //       color: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(75.0),
                  //       ),
                  //       child: Icon(
                  //         Icons.touch_app_sharp,
                  //         color: Colors.white,
                  //       ),
                  //     )),),
                  // Expanded(flex:2,child: Container(
                  //   margin: EdgeInsets.only(
                  //       left: 0, right: 0, top: 100, bottom:0  ),
                  //   height: 40,
                  //   width: 40,),),
                  // Expanded(flex:3,child: Container(
                  //
                  //     margin: EdgeInsets.all(5),
                  //     height: 80,
                  //     width: 80,
                  //     child: Card(
                  //       color: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(40.0),
                  //       ),
                  //       child: Icon(
                  //         Icons.touch_app_sharp,
                  //         color: Colors.white,
                  //       ),
                  //     )),),
                  Container(
                      margin: EdgeInsets.all(5),
                      height: 200,
                      width: 200,
                      child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Icon(
                          Icons.touch_app_sharp,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 40, top: 100, right: 50, bottom: 0),
                      height: 120,
                      width: 120,
                      child: Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      )),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
