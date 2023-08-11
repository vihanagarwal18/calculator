import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'homepage.dart';
import 'splash.dart';
// ignore_for_file: prefer_const_constructors

class Intro extends StatefulWidget {
  final VoidCallback visited;
  const Intro({Key? key, required this.visited}) : super(key: key);
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final _controller = PageController();
  bool _isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111929),
      body: Padding(
        padding: const EdgeInsets.all( 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('asset/logo_panther.jpg'),
              radius: 100,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height:20),
            const Text(
              textAlign: TextAlign.center,
              'This is your first time opening this app\n\nMade by Vihan Agarwal\n\n',
              style: TextStyle(
                color: Color(0xFFE5E3E0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                print(3);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Color(0xFFE5E3E0))),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
