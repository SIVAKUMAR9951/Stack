import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

 mainCatregory() {
  Container(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                    child: Card(

                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )),
                Container(
                  child: Text("All",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
