import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  String? name;
  String? email;
  String? phone;
  _profileData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("name")!;
      email = pref.getString("email")!;
      phone = pref.getString("phone")!;
    });

    print(name! );
    print(email! );
    print(phone! );
  }
  @override
  void initState() {
    super.initState();
    _profileData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75.0),
                      ),
                      child: Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75.0),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "assets/st_logo.png",
                            width: 100.0,
                          ),
                        ),
                      ))),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(name==null?"Author":name!,
                    style: textStyleBold24()),
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                      flex: 2,
                      child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text(email==null?"Demo@gmail.com":email!,
                          style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(5),
                        child: Icon(Icons.email)
                    ),
                       )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text(phone==null?"9000000000":phone!,
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.phone)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Request/Tickets",
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.turned_in_outlined)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Download and My save",
                              style: textStyleNormal18black())),)
                    ,
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.save)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Audio Player Settings",
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.audiotrack)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Language",
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Text("English",
                            style: textStyleNormal12())
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Bookmarks",
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.turned_in_not)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Notification Settings",
                              style: textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.toggle_off_outlined)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(

                        flex: 2,
                        child: Container(margin: EdgeInsets.only(left: 20,top: 5,right: 5,bottom: 5),
                          child: Text("Enable/Disable Voice Commands(Siri/Google)",
                              style:textStyleNormal18black()),)

                    ),
                    Expanded(flex: 1,child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.all(5),
                        child: Icon(Icons.toggle_off_outlined)
                    ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
