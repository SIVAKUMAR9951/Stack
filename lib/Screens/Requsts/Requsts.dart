import 'package:flutter/material.dart';
import 'package:stacklibrary/Screens/Requsts/RequestBook.dart';
import 'package:stacklibrary/Screens/Requsts/RequestStatus.dart';


class Requsts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          tabs: [
            Tab(
              text: "Request Book",
            ),
            Tab(
              text: "Request Status",
            ),
          ],
        ),
        body: TabBarView(
          children: [
            RequestBook(),
            RequestStatus(),
          ],
        ),
      ),
    );
  }
}
