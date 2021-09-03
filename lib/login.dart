import 'package:flutter/material.dart';
import 'package:gametv/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

Widget _backgroundGradient() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.2, 0.6, 1.0],
        colors: [
          Color(0xffae9ddb),
          Color(0xff9284b8),
          Color(0xff4c3f6c),
        ],
      ),
    ),
  );
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundGradient(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    child: Image.asset(
                      'lib/images/gameLogo.png',
                      height: 100,
                      width: 200,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AuthScreen(),
              )
            ],
          )
        ],
      ),
    );
  }
}
