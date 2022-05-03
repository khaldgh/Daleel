import 'dart:convert';
import 'dart:io';

import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/explore_screen.dart';
import 'package:daleel/screens/home_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioo;
import '../models/place.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Places with ChangeNotifier {
  List<String> nameList = [
    'مقاهي',
    'العاب',
    'محلات',
    'مطاعم',
    'ترفيه',
    'مجمعات',
    'حدائق',
    'تسلة',
    'شباب',
    'عوائل',
    'ملابس',
    'فود ترك',
    'سوق جملة',
    'سيراميك',
    'جوالات'
  ];

  List<String> userPreferences = [];

  List<Place> _favoriteList = [];

  List<Place> get favoriteList {
    return [..._favoriteList];
  }

  Future<Place> findById(int id) async {
    String url = 'http://localhost:3000/places/findone/$id';
    print(id);
    dioo.Dio dio = dioo.Dio();
    try {
      dioo.Response response = await dio.get(url);
      Place place = Place.fromJson(response.data);
      print(place);
      return place;
    } catch (e) {
      throw e;
    }
    // bool findPlace = _favoritePlaces.any((element) => element.place_id == id);
    // if (findPlace) {
    //   var place = _favoritePlaces.firstWhere((element) => element.place_id == id);
  }

  Place findByTitle(String title) {
    return _favoritePlaces.firstWhere(
        (place) => place.title?.toLowerCase() == title.toLowerCase());
  }

  List<Place> _favoritePlaces = [];

  List<Place> get favoritePlaces {
    return [..._favoritePlaces];
  }

  void printFunc() {
    print(favoritePlaces);
  }

  Future<List<Place>> getPlaces() async {
    FlutterSecureStorage fStorage = FlutterSecureStorage();
    String? header = await fStorage.read(key: 'cookie');
    String url = 'http://localhost:3000/places/places';
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response<dynamic> response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      List places = response.data as List;
      List<Place> list = places.map((place) => Place.fromJson(place)).toList();
      print(list);

      return list;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> getDetails() async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?language=ar&place_id=ChIJO2w4oJz9ST4RTj5KAwQHza4&key=AIzaSyB9cPWZjeIkrKrAg95mBBuHuXob2YYf-h4';
      dioo.Dio dio = dioo.Dio();
      dioo.Response<dynamic> response = await dio.get(url);
      String data =
          response.data['result']['address_components'][0]['long_name'];
      print(data);
      return data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  List<String> _placeImages = [];
  List<String> get placeImages {
    return [..._placeImages];
  }

  Place? _place;

  Place? get place {
    return _place;
  }

  List<String> _allImages = [];

  List<String> get allImages {
    return [..._allImages];
  }

  bool? loggedIn;

  Future<void> signin(
      String username, String password, BuildContext context) async {
    try {
      // String cookie = '';
      var url = 'http://localhost:3000/users/signin';
      var storage = FlutterSecureStorage();
      var dio = dioo.Dio();
      var response =
          await dio.post(url, data: {'email': username, 'password': password});
      List<String>? cookies = response.headers['set-cookie'];
      for (int i = 0; i <= 1; i++) {
        int cokIndex = cookies![i].indexOf(';');
        String subCookies = cookies[i].substring(0, cokIndex + 1);
        cookie += subCookies + ' ';
      }
      var subbedCookie = cookie.substring(0, cookie.length - 2);
      // print(subbedCookie);

      var write = await storage.write(key: 'cookie', value: subbedCookie);
      var storedCookie = await storage.read(key: 'cookie');
      loggedIn = true;
      print('${cookie} THE COOKIE');
      // [express:sess=eyJ1c2VySWQiOjU1fQ==; path=/; httponly, express:sess.sig=Zy_Lc7kXM1BqZKIZRRt7ygpCTrM; path=/; httponly]
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signup(
      String username, String password, BuildContext context) async {
    try {
      var url = 'http://localhost:3000/users/signup';
      var dio = dioo.Dio();
      var response = await dio.post(
        url,
        data: {'email': username, 'password': password},
        // options: dioo.Options(headers: {'Accept': 'application/json'})
      );
      response;
      loggedIn = true;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> whoami() async {
    try {
      var url = 'http://localhost:3000/users/whoami';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      var response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      print(response.headers);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      var url = 'http://localhost:3000/users/signout';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      await dio.post(url, options: dioo.Options(headers: {'cookie': header}));
      fStorage.delete(key: 'cookie');
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      print(header);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<String?> cookies() async {
    var fStorage = FlutterSecureStorage();
    var storage = await fStorage.read(key: 'cookie');
    cookie = storage!;
  }

  String cookie = '';

  Future<List<Place>> getPreApprovedPlaces() async {
    String url = 'http://localhost:3000/places/pre-approved-places';
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response response = await dio.get(url);
      List<dynamic> places = response.data;
      List<Place> preApprovedList =
          places.map((place) => Place.fromJson(place)).toList();
      return preApprovedList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeApprovalStatus(Place place) async {
    String url = 'http://localhost:3000/places/${place.place_id}';
    try {
      dioo.Dio dio = dioo.Dio();
      await dio.patch(url, data: place);
    } catch (e) {
      throw e;
    }
  }

  Future<void> postPlace(Place place) async {
    String url = 'http://localhost:3000/places';
    var jsonObj = place.toJson();
    // print('${place.category!.categoryId} the function');
    try {
      dioo.Dio dio = dioo.Dio();
      await dio.post(url, data: jsonObj);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deletePlace(int id) async {
    String url = 'http://localhost:3000/places/$id';
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response response = await dio.delete(url);
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> getCities() async {
    String url = 'http://localhost:3000/cities';
    dioo.Dio dio = dioo.Dio();
    List<City> cities = [];
    try {
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      dioo.Response response = await dio.get(url,
          options: dioo.Options(headers: {
            'cookie':
                'express:sess=eyJ1c2VySWQiOjF9; express:sess.sig=q___YW3lYFRdEZV-e_hYwoc_-s0;'
          }));
      List<dynamic> data = response.data;
      data.forEach((key) {
        City jsonCity = City().fromJson(key);
        cities.add(jsonCity);
      });
      print(header);
      return cities.reversed.toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Category>> getCategories() async {
    String url = 'http://localhost:3000/categories';
    Category category = Category();
    dioo.Dio dio = dioo.Dio();
    List<Category> categories = [];
    try {
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((cat) => categories.add(category.fromJson(cat)));
      categories.forEach((element) {
        print(data);
      });
      return categories.reversed.toList();
    } catch (e) {
      throw e;
    }
  }

  List<Neighborhood>? neighborhoods = [];
  Future<List<Neighborhood>> neighborhoodQuery(int city) async {
    String url = 'http://localhost:3000/neighborhoods?city_id=$city';
    dioo.Dio dio = dioo.Dio();
    try {
      if (neighborhoods!.isNotEmpty) neighborhoods!.clear();
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((key) => neighborhoods!.add(Neighborhood().fromJson(key)));
      print(data);
      notifyListeners();
      return neighborhoods!.reversed.toList();
    } catch (e) {
      throw e;
    }
  }

  List<Place> _formPlaces = [];

  List<Place> get formPlaces {
    return [..._formPlaces];
  }

  Place findPlaceById(int id) {
    print(id);
    bool findPlace = formPlaces.any((element) => element.place_id == id);
    if (findPlace) {
      Place place = formPlaces.firstWhere((element) => element.place_id == id);
      return place;
    } else {
      throw Exception('place not found');
    }
  }
}
