import 'dart:convert';
import 'dart:io';

import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
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
    try {
      String url = 'http://localhost:3000/places/places';
      dioo.Dio dio = dioo.Dio();
      dioo.Response<dynamic> response = await dio.get(url);
      List places = response.data as List;
      List<Place> list = places.map((place) => Place.fromJson(place)).toList();
      for (int i = 0; i < places.length; i++) {
        if (_favoritePlaces
            .any((element) => element.place_id == list[i].place_id)) {
        } else {
          _favoritePlaces.add(list[i]);
        }
      }
      print(list);

      return list;

      // return places;

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
      for (int i = 0; i <= cookies!.length - 1; i++) {
        var cokIndex = cookies[i].indexOf(';');
        var subCookies = cookies[i].substring(0, cokIndex + 1);
        cookie += subCookies + ' ';
      }
      var subbedCookie = cookie.substring(0, cookie.length - 2);
      print(subbedCookie);

      storage.write(key: 'cookie', value: subbedCookie);
      loggedIn = true;
      // print(response.headers['set-cookie']);
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
      var url = 'https://daleel-app.herokuapp.com/users/signup';
      var dio = dioo.Dio();
      var response = await dio.post(url,
          data: {'email': username, 'password': password},
          options: dioo.Options(headers: {'Accept': 'application/json'}));
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
      var url = 'https://daleel-app.herokuapp.com/users/whoami';
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
      var url = 'https://daleel-app.herokuapp.com/users/signout';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      await dio.post(url, options: dioo.Options(headers: {'cookie': header}));
      fStorage.delete(key: 'cookie');
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      print('you reached here');
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

  Place userPlace = Place(
    // id: 0,
    title: '',
    description: '',
    category: Category(categoryId: 1,category: ''),
    approved: false,
    phone: 0,
    instagram: '',
    website: '',
    neighborhoods: [],
    weekdays: [],
    images: [],
    // isFavorite: null,
    // time: null
  );

  List<String> cities = ['الدمام', 'الظهران', 'الخبر', 'الجبيل'];

  Future<void> postPlace(Place place) async {
    try {
      dioo.Dio dio = dioo.Dio();
      // dioo.Response response =
      await dio.post('http://localhost:3000/places', data: place.toJson());
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> getCities() async {
    String url = 'http://localhost:3000/cities';
    dioo.Dio dio = dioo.Dio();
    List<City> cities = [];
    try {
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((key) {
        City jsonCity = City().fromJson(key);
        cities.add(jsonCity);
      });
      print(data);
      print(cities);
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
        print(element.category);
      });
      return categories.reversed.toList();
    } catch (e) {
      throw e;
    }
  }

  List<String>? neighborhoods = [];
  Future<List<String>> neighborhoodQuery(int city) async {
    String url = 'http://localhost:3000/neighborhoods?city_id=$city';
    dioo.Dio dio = dioo.Dio();
    try {
      if (neighborhoods!.isNotEmpty)
        // neighborhoods!.removeRange(0, neighborhoods!.length);
        neighborhoods!.clear();
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((key) => neighborhoods!.add(key['neighborhood']!));
      print('neighborhoods query');
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
