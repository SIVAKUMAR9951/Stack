import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Screens/Account/Accounts.dart';
import 'package:stacklibrary/Screens/Login_Screen/Login_Main.dart';
import 'package:stacklibrary/Screens/Notification/Notifications.dart';
import 'package:stacklibrary/Screens/Search/Search.dart';
import 'package:stacklibrary/Widgets/AppBar.dart';
import 'package:stacklibrary/Widgets/ChangeThemeButtonWidget.dart';
import 'package:stacklibrary/main.dart';

import 'package:flutter/widgets.dart';
import 'package:stacklibrary/provider/themes.dart';
import 'Category/Audio__Category.dart';
import 'Category/Book_Category.dart';
import 'Category/Documents_Category.dart';
import 'Category/Magazines_Category.dart';
import 'Category/Podcasts_Category.dart';
import 'Category/Videos_Category.dart';
import 'Category/All.dart';
import 'HomePages/Home_Category.dart';
import 'MySaves/My_Saves.dart';
import 'Requsts/Requsts.dart';

import 'package:http/http.dart' as http;
class Home_page extends StatefulWidget {
   Home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<Home_page> {
  final GlobalKey<ScaffoldState> _globalKey=new  GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  late PageController _pageController;
  List<Widget> _widgetOptions = [
    Screen1(),
    Requsts(),
    My_Saves(),
    Accounts(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ?Color(0xFF009EF7)
        :  Color(0xFF000000) ;
    return Scaffold(

      appBar: AppBar(

        leading: new IconButton(
          onPressed: (){
            if(_globalKey.currentState!.isDrawerOpen==false){
              _globalKey.currentState!.openDrawer();
            }else{
              _globalKey.currentState!.openEndDrawer();
            }
          },
          icon: new Icon(
            Icons.menu,
            color: Colors.white,
          ),

        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
            )
        ),
        // backgroundColor: themecolor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Search()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Notifications()));
            },
          ),
        ],

        title: Container(alignment: Alignment.center,
        child: Image.asset('assets/st_logo.png',height: 50,color: Colors.white,
            fit: BoxFit.cover),),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTabTapped,
        iconSize: 20,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.grey),

        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/home.png",
                width: 24.0,
              ),
              // activeIcon:new Image.asset('assets/save.png')
              title: Text("Home",style: textStyleBold(),)),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/file/re_book.jpeg",
                width: 24.0,
              ),
              title: Text("Requst Book",style: textStyleBold())),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/save.png",
                width: 24.0,
              ),
              title: Text("My Saves",style: textStyleBold())),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/users.png",
                width: 24.0,
              ),
              title: Text("Profile",style: textStyleBold())),
        ],
      ),
      body: Scaffold(
        key: _globalKey,

        drawer: Drawer(

          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // place the logout at the end of the drawer
            children: <Widget>[
              Flexible(

                child: ListView(

                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      height: 120,
                      color: Colors.black26,
                      child: Row(
                        children: [
                          Expanded(flex: 1,child:
                          Container(
                            height: 80.0,
                            width: 80.0,
                            child: CircleAvatar(
                            backgroundColor:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.white
                                : Colors.white,
                            child: Image.asset(
                              "assets/st_logo.png",
                              width: 70.0,
                              height: 70.0,
                            ),
                          ),)),
                          Expanded(flex:1,child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,child:Text("Siva kumar",
                                style: textStyleBold16())),
                                Container( margin: EdgeInsets.all(5),alignment: Alignment.topLeft,child:Text("Mobile Application Devoloper",
                                    style: textStyleBold16()),),
                              ],
                            ),
                          ))
                        ],
                      ),

                    ),
                   /* UserAccountsDrawerHeader(

                      decoration: BoxDecoration(color: Colors.black12),
                      accountName: Padding(
                        child: Row(
                          children: <Widget>[
                            Text("Siva kumar",
                                style: textStyleBold16()),
                          ],
                        ),
                        padding: EdgeInsets.only(top: 10),
                      ),
                      accountEmail: Text("Mobile Application Devoloper",
                          style: textStyleBold16()),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.white
                            : Colors.white,
                        child: Image.asset(
                          "assets/st_logo.png",
                          width: 47.0,
                        ),
                      ),
                    ),*/
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Home",style: textStyleNormal18black()),
                      leading: Image.asset("assets/home.png"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home_page()),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Search()),
                        );
                      },
                      dense: true,
                      title: Text("Browse Books",style: textStyleNormal18black()),
                      leading: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        void dispose(){

                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => My_Saves()),
                        // );
                      },
                      dense: true,
                      title: Text("My Save",style: textStyleNormal18black()),
                      leading: Image.asset("assets/save.png"),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      dense: true,
                      title: Text("Request a Book",style: textStyleNormal18black()),
                      leading: Image.asset("assets/file/re_book.jpeg"),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Requsts()),
                        // );
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context,true);
                        // Accounts();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Accounts()),
                        // );
                      },
                      dense: true,
                      title: Text("Account ",style: textStyleNormal18black()),
                      leading: Image.asset(
                        "assets/users.png",
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context,MaterialPageRoute(builder: (context) => Home_page()));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Home_page()),
                        // );
                      },
                      dense: true,
                      title: Text("Reading",style: textStyleNormal18black()),
                      leading: Icon(
                        Icons.menu_book,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () async {
                        SharedPreferences prefrences = await SharedPreferences.getInstance();
                        await prefrences.clear();
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Login_Main()));
                      },
                      dense: true,
                      title: Text("Logout",style: textStyleNormal18black()),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/st_logo.png",color: Colors.black26,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
       body: PageView(
          children: _widgetOptions,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
      )


    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._selectedIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: new Size(10.0, 90.0),
          child: new Container(

            child: new TabBar(
              isScrollable: true,
              tabs: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          width: 60,

                              child: Card(
                                elevation: 20,
                                margin: EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Image.asset(
                                  "assets/file/re_all.jpeg",
                                  width: 47.0,
                                ),
                              )),
                      Container(
                        child: Text("All ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,

                          child: Card(
                            elevation: 20,
                            margin: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Image.asset(
                              "assets/file/re_book.jpeg",
                              width: 47.0,
                            ),
                          ),

                      ),
                      Container(
                        child: Text("Books",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,

                            child: Card(
                              elevation: 20,
                              margin: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Image.asset(
                                "assets/file/re_audio.jpeg",
                                width: 47.0,
                              ),
                            ),
                      ),
                      Container(
                        child: Text("Audiobooks",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,

                            child: Card(
                              elevation: 20,
                              margin: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Icon(
                                Icons.video_call,
                                color: Colors.black,

                            )),
                      ),
                      Container(
                        child: Text("Videos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            All(),
            Book_Category(),
            // Magazines_Category(),
            Audio_Category(),
            // Podcasts_Category(),
            // Documents_Category(),
            Video_Category(),
            // My_Saves(),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Center(child: Text("Screen 3")),
    );
  }
}
