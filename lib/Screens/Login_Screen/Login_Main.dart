import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Controls/Book_Controler.dart';
import 'package:stacklibrary/Models/LoginModel.dart';
import 'package:stacklibrary/Screens/HomePage.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';

class Login_Main extends StatefulWidget {
  const Login_Main({Key? key}) : super(key: key);

  @override
  _Login_MainState createState() => _Login_MainState();
}

class _Login_MainState extends State<Login_Main> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  _loginCommand(
    email,
    password,
  ) async {
    print(email + "    " + password);
    Map data = {'name': email, 'password': password};
    print(data.toString());
    final response =
        await http.post(Uri.parse("http://stack.kriyaninfotech.com/api/login"),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map<String, dynamic> resposne2 = jsonDecode(response.body);
      print(resposne2['user']['api_login_token']);
      print(resposne2['token']);
      // var jsonData = json.decode(data.body);
      setState(() {
        savePref(
            resposne2['user']['id'].toString(),
            resposne2['user']['username'],
            resposne2['user']['name'],
            resposne2['user']['email'],
            resposne2['user']['phone'],
            resposne2['token']);

      });
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home_page()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,
          content: Text('Please enter valid Username and Password',style: textStyleBoldwhite(),)));
    }

  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Image.asset('assets/st_logo.png',height: 150,width: 150,)),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                        validator: (val) =>
                        val!.isEmpty ? 'Please provide a valid User Name.' : null,
                        style: textStyleNormal18black(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (val) =>
                        val!.length<4? 'Please Enter Password' : null,
                        style: textStyleNormal18black(),
                      ),
                    ),
                    Container(alignment: Alignment.topRight,
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Home_page()));
                        },
                        textColor: Colors.blue,
                        child: Text('Forgot Password'),
                      ),),

                    Container(
                        height: 50,
                        width: 300,

                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Login'),
                          onPressed: () {
                            print(nameController.text);
                            print(passwordController.text);
                            if (_formKey.currentState!.validate()) {
                              _loginCommand(
                                nameController.text,
                                passwordController.text,
                              );
                            }

                          },
                        )),

                  ],
                ),
              )),
        ));
  }
  savePref(String id, String username, String name, String email, String phone,
      String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("phone", phone);
    preferences.setString("api_login_token", token);
    preferences.commit();
  }
}

// class _Login_MainState extends StateMVC<Login_Main> {
//   Book_Controler _book_controler = Book_Controler();
//
//   LoginModel? modellogin;
//
//   _Login_MainState() : super(Book_Controler());
//
//   final _formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController _email = new TextEditingController();
//   TextEditingController _password = new TextEditingController();
//   late String email, password;
//   bool visible = false;
//
// /*
//   void _submitCommand() {
//     final form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       if (_email.text.isEmpty || _password.text.isEmpty) {
//         final snackbar = SnackBar(content: Text("Please Fill all fileds"));
//         scaffoldKey.currentState!.showSnackBar(snackbar);
//         return;
//       }
//       // _book_controler.getloginDetails(email, password,);
//       // _loginCommand(_email.text, _password.text);
//     }
//   }
//
//   _loginCommand(
//     email,
//     password,
//   ) async {
//     print(email + "    " + password);
//     setState(() {
//       visible = true;
//     });
//
//     Map data = {'name': email, 'password': password};
//     print(data.toString());
//     final response =
//         await http.post(Uri.parse("http://stack.kriyaninfotech.com/api/login"),
//             headers: {
//               "Accept": "application/json",
//               "Content-Type": "application/x-www-form-urlencoded"
//             },
//             body: data,
//             encoding: Encoding.getByName("utf-8"));
//     print(response.body);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(response.statusCode);
//       Map<String, dynamic> resposne2 = jsonDecode(response.body);
//       print(resposne2['user']['api_login_token']);
//       print(resposne2['token']);
//       // var jsonData = json.decode(data.body);
//       setState(() {
//         savePref(
//             resposne2['user']['id'].toString(),
//             resposne2['user']['username'],
//             resposne2['user']['name'],
//             resposne2['user']['email'],
//             resposne2['user']['phone'],
//             resposne2['token']);
//         visible = false;
//       });
//       Navigator.push(context, MaterialPageRoute(builder: (_) => Home_page()));
//     } else {
//       setState(() {
//         visible = false;
//       });
//       final snackbar = SnackBar(content: Text("Please check user details!"));
//       scaffoldKey.currentState!.showSnackBar(snackbar);
//     }
//
//     final snackbar = SnackBar(
//       content: Text('Email: $_email, password: $_password'),
//     );
//     scaffoldKey.currentState!.showSnackBar(snackbar);
//   }
// */
//
//   @override
//   void initState() {
//     // _clearPrif();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Login Page"),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(left: 10,top: 30.0,right: 10,bottom: 10),
//                 child: Center(
//                   child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 8.0),
//                       width: 200,
//                       height: 150,
//                       /*decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(50.0)),*/
//                       child: Image.asset('assets/st_logo.png')),
//                 ),
//               ),
//               Padding(
//                 //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: TextFormField(
//                   controller: _email,
//                   validator: (val) =>
//                       val!.isEmpty ? 'Please provide a valid User Name.' : null,
//                   onSaved: (val) {
//                     email = val!;
//                   },
//                   decoration: InputDecoration(
//                       labelText: 'User Name',
//                       hintText: 'Enter valid User Name'),
//                   style: textStyleNormal18black(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 15.0, right: 15.0, top: 5, bottom: 0),
//                 //padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: TextFormField(
//                   controller: _password,
//                   validator: (val) =>
//                       val!.length < 4 ? 'Your password is too short..' : null,
//                   onSaved: (val) => password = val!,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       labelText: 'Password', hintText: 'Enter secure password'),
//                   style: textStyleNormal18black(),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(10),
//                 alignment: Alignment.centerRight,
//                 child: FlatButton(
//                   onPressed: _submitCommand,
//                   child: Text(
//                     'Forgot Password',
//                     style: TextStyle(color: Colors.blue, fontSize: 15),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.all(5),
//                 height: 50,
//                 width: 250,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: FlatButton(
//                   onPressed: _submitCommand,
//                   child: Text(
//                     'Login',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 child: (visible)
//                     ? Center(
//                         child: Container(
//                             height: 50,
//                             width: 50,
//                             child: CircularProgressIndicator(
//                               backgroundColor: Colors.blue,
//                             )))
//                     : Container(),
//                 right: 30,
//                 bottom: 0,
//                 top: 0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /*savePref(String id, String username, String name, String email, String phone,
//       String token) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//
//     preferences.setString("id", id);
//     preferences.setString("username", username);
//     preferences.setString("name", name);
//     preferences.setString("email", email);
//     preferences.setString("phone", phone);
//     preferences.setString("api_login_token", token);
//     preferences.commit();
//   }
//
//   void _clearPrif() async{
//     print("clear Data!!!!!");
//     WidgetsFlutterBinding.ensureInitialized();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('api_login_token');
//   }*/
//
//   void _submitCommand() {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => Home_page()));
//   }
// }
