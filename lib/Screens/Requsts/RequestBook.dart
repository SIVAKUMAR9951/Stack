import 'package:flutter/material.dart';


class RequestBook extends StatefulWidget {
  const RequestBook({Key ?key}) : super(key: key);

  @override
  _RequestBookState createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              child: Text("Select Requst Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black)),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 5),
                        child: Text("Please Select Request Type  ",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.keyboard_arrow_down)),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 5, top: 5, right: 5, bottom: 5),
                        child: Text("Please Select Book Type  ",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.keyboard_arrow_down)),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Please enter author name'),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Please enter addition number'),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
              child: TextField(
                decoration: InputDecoration(hintText: 'Please enter comments'),
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => Requsts()));
                },
                child: Text(
                  'Save details',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
