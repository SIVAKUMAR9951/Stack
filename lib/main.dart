import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacklibrary/Screens/HomePage.dart';
import 'package:stacklibrary/provider/themes.dart';


import 'Screens/Login_Screen/Login_Main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context)  => ChangeNotifierProvider(
  /*  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );*/

    create: (context) => ThemeProvider(),
    builder: (context, _) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
    title: 'Introduction screen',
    // debugShowCheckedModeBanner: false,
    // themeMode: themeProvider.themeMode,
    // theme: MyThemes.lightTheme,
    // darkTheme: MyThemes.darkTheme,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: OnBoardingPage(),
    );
    },
  );

}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  String? auth_token;
  readingBooks() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("api_login_token"));
    if(pref.getString("api_login_token")==null){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Login_Main()),
      );
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.remove('api_login_token');
    }else {
      auth_token = pref.getString("api_login_token")!;
    }
  }

  @override
  void initState() {

    readingBooks();
    super.initState();
  }

  void _onIntroEnd(context) {
    print("mainlogin  "+auth_token!);
    if(auth_token==null || auth_token!.isEmpty){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Login_Main()),
      );
    }else{
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Home_page()),
      );
    }


  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/logo.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 300]) {
    return Image.asset('assets/st_logo.png', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: new Image.asset(
      //         "assets/logo.jpg",
      //       ),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Get Stared',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () =>_onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "BOOK",
          body:
          "a collection of materials, books or media that are easily accessible for use",
          image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book",
          body:
          "a collection of materials, books or media that are easily accessible for use",
          image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book",
          body:
          "a collection of materials, books or media that are easily accessible for use",
          image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book",
          body:
          "a collection of materials, books or media that are easily accessible for use",
          image:_buildImage('img3.jpg'),
          decoration: pageDecoration,

        ),
        PageViewModel(
          title: "Book",
          body: "a collection of materials, books or media that are easily accessible for use",
          image: _buildImage('img2.jpg'),

          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}
