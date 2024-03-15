import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState(){
    startTimer();
    super.initState();
  }
  startTimer(){
    var  duration = Duration(seconds: 5);
    return Timer(duration, route);
  }
  route(){
    Navigator.of(context).pushReplacementNamed('/login');
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Image.network("https://th.bing.com/th/id/OIP.ytaNAKRuDddbHHWD3sNQSAHaHa?w=600&h=600&rs=1&pid=ImgDetMain",
          height: 100,
          width: 100,
          ),
          SizedBox(height: 10),
          Text("Blood Donation",
          style: TextStyle(fontSize: 30),
          )
            ],
          ),
          
        ),
      ),
    );
  }
}