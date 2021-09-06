
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key ?key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),

      ),
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("assets/Image.png"),
      ),
    );
  }
}
