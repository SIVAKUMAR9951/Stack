
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Models/LoginModel.dart';
import 'package:stacklibrary/Models/ModelAllBook.dart';
import 'package:stacklibrary/Repository/All_Repository.dart';

class Book_Controler extends ControllerMVC {

  List<ModelAllBook> newBookModelList = [];
  List<LoginModel> _loginmodelList = [];
  ModelAllBook? modelAllBook;
  LoginModel? modellogin;
  String? auth_token;
  Book_Controler() {
    this.modelAllBook = ModelAllBook();
    this.modellogin = LoginModel();
  }
  var globalkey = GlobalKey<ScaffoldState>();

  getloginDetails(email, password) async{
    print("login Data");
    try {
      _loginmodelList = await getloginData(email,password);
      setState(() {
        // getloginDetails(email,password);
      });
    } catch (e) {
      print("Dataa    :   +e");
    }
  }


  getAllBooks() async {
    print("ok book_controler");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    auth_token = pref.getString("api_login_token")!;
    print(auth_token!+"  Book All");
    try {
      newBookModelList = await getAllBooksAPI1(auth_token);
      setState(() {
        // getAllBooks();
      });
    } catch (e) {
      print("Dataa    :   +e");
    }
  }

}
