
import 'package:flutter/material.dart';

class RequestStatus extends StatefulWidget {
  const RequestStatus({Key ?key}) : super(key: key);

  @override
  _RequestStatusState createState() => _RequestStatusState();
}

class _RequestStatusState extends State<RequestStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20,top: 10,right: 10,bottom: 10),
              child: Text("Requst Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            ),
          ],
        ),
      )
    );
  }
}
