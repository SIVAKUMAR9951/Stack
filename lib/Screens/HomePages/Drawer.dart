import 'dart:js';

import 'package:flutter/material.dart';

import '../HomePage.dart';
import '../PageOne.dart';

Drawer saidDrawer(BuildContext context){
 return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween, // place the logout at the end of the drawer
      children: <Widget>[
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                accountName: Padding(
                  child: Row(
                    children: <Widget>[
                      Text("Siva kumar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white)),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10),
                ),
                accountEmail: Text("Mobile Application Devoloper",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.red
                      : Colors.white,
                  child: Image.asset(
                    "Images/Amara_raja_group.png",
                    width: 47.0,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                title: Text("Home"),
                leading: Icon(
                  Icons.linear_scale,
                  color: Colors.brown,
                  size: 16,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_page()),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageOne()),
                  );
                },
                dense: true,
                title: Text("Browse Books"),
                leading: Icon(
                  Icons.linear_scale,
                  color: Color(0xFFB2D233),
                  size: 16,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageOne()),
                  );
                },
                dense: true,
                title: Text("My Save"),
                leading: Icon(
                  Icons.linear_scale,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
              ListTile(
                dense: true,
                title: Text("Request a Book"),
                leading: Icon(
                  Icons.linear_scale,
                  color: Colors.green,
                  size: 16,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageOne()),
                  );
                },
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageOne()),
                  );
                },
                dense: true,
                title: Text("Account "),
                leading: Icon(
                  Icons.linear_scale,
                  color: Colors.green,
                  size: 16,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home_page()),
                  );
                },
                dense: true,
                title: Text("Reading"),
                leading: Icon(
                  Icons.linear_scale,
                  color: Colors.green,
                  size: 16,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              )
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          dense: true,
          title: Text("Logout"),
          trailing: Text(
            "Version 0.0",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          leading: Icon(
            Icons.logout,
            size: 16,
          ),
        ),
      ],
    ),
  );
}