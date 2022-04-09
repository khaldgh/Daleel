import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:daleel/widgets/signup_widgets/signin_widget.dart';
import 'package:daleel/widgets/signup_widgets/signup_widget.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool emailLogin = false;
  bool loginStatus = false;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  dispose() {
    email.dispose();
    username.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.purple[200]!, Colors.black26]),
            image: DecorationImage(
              image: AssetImage('assets/images/login.webp'),
              fit: BoxFit.cover,
              opacity: 0.7,
            )),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: !emailLogin
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'sign up',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(2, 2))
                          ]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          SignInButton(Buttons.FacebookNew, onPressed: () {}),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(Buttons.Google, onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(Buttons.Email, onPressed: () {
                        setState(() {
                          emailLogin = true;
                        });
                      }),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Skip',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(1, 1))
                              ])),
                    )
                    // loginStatus
                    //     ? SigninWidget(username, password)
                    //     : SignupWidget(username, password, email),
                    // ElevatedButton(
                    //   child: Text('login'),
                    //   onPressed: () {
                    //     loginStatus
                    //         ? places.signin(username.text, password.text, context)
                    //         : places.signup(username.text, password.text, context);
                    //   },
                    // ),
                    // TextButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         loginStatus = !loginStatus;
                    //         print(loginStatus);
                    //       });
                    //     },
                    //     child: Text(loginStatus ? 'signup' : 'signin'))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginStatus
                        ? SigninWidget(username, password)
                        : SignupWidget(username, password, email),
                    ElevatedButton(
                      child: Text(loginStatus ? 'login' : 'sign up'),
                      onPressed: () {
                        loginStatus
                            ? places.signin(
                                username.text, password.text, context)
                            : places.signup(
                                username.text, password.text, context);
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loginStatus = !loginStatus;
                            print(loginStatus);
                          });
                        },
                        child: Text(loginStatus ? 'signup' : 'signin')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            emailLogin = false;
                          });
                        },
                        child: Text('go back'))
                  ],
                ),
        ),
      ),
    );
  }
}
