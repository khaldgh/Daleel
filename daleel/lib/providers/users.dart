

import 'package:daleel/models/user.dart';
import 'package:daleel/screens/home_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Users with ChangeNotifier {


  String cookie = '';

  bool? loggedIn;

  // var test = 'express:sess=eyJ1c2VySWQiOjV9; path=/; httponly, express:sess.sig=r27Nmwky98zweHbow96vwqWHsiw; path=/; httponly';
  //       test.startsWith('express');
  //       var list = test.split(';');
  //       var list1 = list[0] + ';';
  //       var list2 = list[2].substring(list[2].indexOf('express')) + ';';
  //       var prnt = list1 + list2;
  //       print(prnt);

  Future<void> signup(String email, String username, String password,
      BuildContext context) async {
    try {
      var url = 'http://192.168.68.107:3000/users/signup';
      var dio = dioo.Dio();
      var storage = FlutterSecureStorage();
      var response = await dio.post(
        url,
        data: {'email': email, 'username': username, 'password': password},
        options: dioo.Options(headers: {'Accept': 'application/json'})
      );
      List<String>? cookies = response.headers['set-cookie'];
      String sub1 = cookies![0].substring(0, 34);
      String sub2 = cookies[1].substring(0, 45);
      cookie = sub1 + sub2;

      await storage.write(key: 'cookie', value: cookie);

      print('${await storage.read(key: 'cookie')} I AM COOKIE');

      response;
      loggedIn = true;
      GoRouter.of(context).go(PreferencesScreen.routeName);
    } catch (err) {
      throw err;
    }
  }

  Future<void> signin(
      String username, String password, BuildContext context) async {
    try {
      // String cookie = '';
      var url = 'http://192.168.68.107:3000/users/signin';
      var storage = FlutterSecureStorage();
      var dio = dioo.Dio();
      var response =
          await dio.post(url, data: {'email': username, 'password': password});
      List<String>? cookies = response.headers['set-cookie'];
      String sub1 = cookies![0].substring(0, 30);
      String sub2 = cookies[1].substring(0, 45);
      cookie = sub1 + sub2;


      await storage.write(key: 'cookie', value: cookie);

      print('${await storage.read(key: 'cookie')} I AM COOKIE');

      loggedIn = true;
      // [express:sess=eyJ1c2VySWQiOjU1fQ==; path=/; httpsonly, express:sess.sig=Zy_Lc7kXM1BqZKIZRRt7ygpCTrM; path=/; httpsonly]
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      GoRouter.of(context).go(HomeScreen.routeName);
    } catch (err) {
      throw err;
    }
  }


  Future<User> whoami() async {
    try {
      var url = 'http://192.168.68.107:3000/users/whoami';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      var response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      return User.fromJson(response.data);
    } catch (err) {
      throw err;
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      // var url = 'http://192.168.68.107:3000/users/signout';
      // var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      // var header = await fStorage.read(key: 'cookie');
      // await dio.post(url, options: dioo.Options(headers: {'cookie': header}));
      await fStorage.delete(key: 'cookie');
      GoRouter.of(context).go(LoginScreen.routeName);
    } catch (err) {
      throw err;
    }
  }
}