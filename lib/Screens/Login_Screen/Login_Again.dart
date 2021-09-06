import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacklibrary/Screens/Forgot_Screen/Forgot_Page.dart';
import 'package:stacklibrary/Screens/HomePage.dart';
import 'package:stacklibrary/Screens/Login_Screen/Login_Main.dart';

class Login_Again extends StatefulWidget {
  const Login_Again({Key? key}) : super(key: key);

  @override
  _Login_MainState createState() => _Login_MainState();
}

class _Login_MainState extends State<Login_Again> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/logo.jpg')),
              ),
            ),
            Container(
                margin: EdgeInsets.all(5),
              height: 100,
                width: 100,
                child: Card(
                  color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Icon(
                Icons.touch_app_sharp,
                color: Colors.white,
              ),
            )),
            Container(
                margin: EdgeInsets.all(5),
              child: Text("your password has been changed successfully. please log in to continue",style: TextStyle(),)
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 25, bottom: 15  ),
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login_Main()));
                },
                child: Text(
                  'Goto Login Page',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
