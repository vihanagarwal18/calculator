import 'package:calculator/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Intro.dart';
import 'splash.dart';
// ignore_for_file: prefer_const_constructors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var boolKey = 'isFirstTime';
  var isFirstTime = prefs.getBool(boolKey) ?? true;

  if (isFirstTime) {
    await prefs.setBool(boolKey, false);
  }

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget{
  final bool isFirstTime;
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF111929),)
      ),
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      home: isFirstTime ? AppStart() : HomeScreen(),
    );
  }

}
class AppStart extends StatefulWidget {
  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  Future<bool> hasVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasVisited = prefs.getBool('notVisited') ?? true;
    return hasVisited;
  }

  void notVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notVisited', false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasVisited(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return Intro(
            visited: () {
              notVisited();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          );
        } else {
          return HomeScreen();
        }
      },
    );
  }
}




// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: HomeScreen(),
// ));