
import 'package:http/http.dart' as http;
import 'package:stacklibrary/Models/LoginModel.dart';
import 'package:stacklibrary/Models/ModelAllBook.dart';
import 'dart:convert';

Future<List<ModelAllBook>> getAllBooksAPI1(String? auth_token) async {
  Map data = {'token': auth_token};
  print(auth_token! + "  token3");
  var result = await http
      .post(Uri.parse("http://stack.kriyaninfotech.com/api/relatedbooks/21"),body: data,);
  print(result.body);
  var jsonData = jsonDecode(result.body);
  // return json.decode(result.body)["relatedbooks"];

  return (jsonData["relatedbooks"] as List).map((e) => ModelAllBook.fromJSON(e)).toList();

}

Future<List<LoginModel>> getloginData(email,password) async {
  print("login Data All_Repo");
  String url = "http://stack.kriyaninfotech.com/api/login";
  var data = await http.post(Uri.parse(url), headers: {"Accept": "application/json","Content-Type": "application/x-www-form-urlencoded"}, body: {
    'name':email,
    'password': password
  });
  Map<String, dynamic> resposne2 = jsonDecode(data.body);
  // var jsonData = json.decode(data.body);
  print(resposne2['user']);

  return (resposne2['user'] as List).map((e) => LoginModel.fromJSON(e)).toList();
}


//
// Future<List<LoginModel>> getloginData(email, password) async {
//   print(email + "    " + password);
//   Map data = {'name': email, 'password': password};
//   print(data.toString());
//   var response =
//   await http.post(Uri.parse("http://stack.kriyaninfotech.com/api/login"),
//       headers: {
//         "Accept": "application/json",
//
//       },
//       body: data,
//       encoding: Encoding.getByName("utf-8"));
//   print(response.body);
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     print(response.statusCode);
//     Map<String, dynamic> resposne2 = jsonDecode(response.body);
//     print(resposne2['user']);
//     // var jsonData = json.decode(data.body);
//   return (resposne2['allbooks'] as List).map((e) => LoginModel.fromJSON(e)).toList(); ;
//
//   }
//
// }

