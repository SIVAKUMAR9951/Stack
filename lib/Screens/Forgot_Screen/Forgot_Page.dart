import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacklibrary/Screens/HomePage.dart';
import 'package:stacklibrary/Screens/Login_Screen/Login_Again.dart';

class Forgot_Page extends StatefulWidget {
  const Forgot_Page({required Key key}) : super(key: key);

  @override
  _Login_MainState createState() => _Login_MainState();
}

class _Login_MainState extends State<Forgot_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                  child: Text("Sivakumar",style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(  
                    labelText: 'Enter Password',
                    hintText: 'Enter Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15  ),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Conforme Password',
                    hintText: 'Conforme password'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login_Again()));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
