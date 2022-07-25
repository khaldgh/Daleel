import 'dart:ui';

import 'package:daleel/providers/users.dart';
import 'package:flutter/material.dart';

import 'package:daleel/widgets/signup_widgets/signin_widget.dart';
import 'package:daleel/widgets/signup_widgets/signup_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    var users = Provider.of<Users>(context);
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
                      'تسجيل الدخول',
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
                          SignInButton(Buttons.FacebookNew, onPressed: () {}, text: 'سجل دخولك عبر فيسبوك',),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(Buttons.Twitter, onPressed: () {}, text: 'سجل دخولك عبر تويتر',),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SignInButton(Buttons.Google, onPressed: () {}, text: 'سجل دخولك عبر قوقل',),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(Buttons.Google, onPressed: () {}, text: 'سجل دخولك عبر قوقل',),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SignInButton(Buttons.Email, onPressed: () {
                        setState(() {
                          emailLogin = true;
                        });
                      }, text: 'سجل عبر بريدك الالكتروني',),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('تخطي',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(1, 1))
                              ])),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loginStatus
                        ? SigninWidget(username, password)
                        : SignupWidget(email, username, password),
                    ElevatedButton(
                      child: Text(loginStatus ? 'تسجيل الدخول' : 'انشاء حساب'),
                      onPressed: () {
                        loginStatus
                            ? users.signin(
                                username.text, password.text, context)
                            : users.signup(
                                email.text, username.text, password.text, context);
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loginStatus = !loginStatus;
                            print(loginStatus);
                          });
                        },
                        child: Text(loginStatus ? 'اضغط لإنشاء حساب' : 'اضغط لتسجيل الدخول', style: TextStyle(color: Colors.white,))),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            emailLogin = false;
                          });
                        },
                        child: Text('العودة', style: TextStyle(color: Colors.white,)))
                  ],
                ),
        ),
      ),
    );
  }
}
