import 'dart:convert';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/comment.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/explore_screen.dart';
import 'package:daleel/screens/home_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioo;
import 'package:image_picker/image_picker.dart';
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

  FlutterSecureStorage fStorage = FlutterSecureStorage();
  

  List<String> userPreferences = [];

  List<Place> _favoriteList = [];

  List<Place> get favoriteList {
    return [..._favoriteList];
  }

  Future<Place> findById(int id) async {
    String url = 'http://192.168.8.105:3000/places/findone/$id';
    String? cookie = await FlutterSecureStorage().read(key: 'cookie');
    print(id);
    dioo.Dio dio = dioo.Dio();
    try {
      dioo.Response response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': cookie}));
      Place place = Place.fromJson(response.data);
      print(response.data);
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

  Future<List<Place>> getPlaces() async {
    String? header = await fStorage.read(key: 'cookie');
    String url = 'http://192.168.8.105:3000/places/places';
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

  bool? loggedIn;

  String cookie = '';

  Future<void> signin(
      String username, String password, BuildContext context) async {
    try {
      // String cookie = '';
      var url = 'http://192.168.8.105:3000/users/signin';
      var storage = FlutterSecureStorage();
      var dio = dioo.Dio();
      var response =
          await dio.post(url, data: {'email': username, 'password': password});
      List<String>? cookies = response.headers['set-cookie'];
      String sub1 = cookies![0].substring(0, 30);
      String sub2 = cookies[1].substring(0, 45);
      cookie = sub1 + sub2;

      var write = await storage.write(key: 'cookie', value: cookie);
      print(await storage.read(key: 'cookie'));
      // print(cookies);
      loggedIn = true;
      // [express:sess=eyJ1c2VySWQiOjU1fQ==; path=/; httponly, express:sess.sig=Zy_Lc7kXM1BqZKIZRRt7ygpCTrM; path=/; httponly]
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signup(String email, String username, String password,
      BuildContext context) async {
    try {
      var url = 'http://192.168.8.105:3000/users/signup';
      var dio = dioo.Dio();
      var storage = FlutterSecureStorage();
      var response = await dio.post(
        url,
        data: {'email': email, 'username': username, 'password': password},
        // options: dioo.Options(headers: {'Accept': 'application/json'})
      );
      List<String>? cookies = response.headers['set-cookie'];
      String sub1 = cookies![0].substring(0, 34);
      String sub2 = cookies[1].substring(0, 45);
      cookie = sub1 + sub2;

      await storage.write(key: 'cookie', value: cookie);

      response;
      loggedIn = true;
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<User> whoami() async {
    try {
      var url = 'http://192.168.8.105:3000/users/whoami';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      var response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      print(response.data);
      return User.fromJson(response.data);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      var url = 'http://192.168.8.105:3000/users/signout';
      var dio = dioo.Dio();
      var fStorage = FlutterSecureStorage();
      var header = await fStorage.read(key: 'cookie');
      print(header);
      // await dio.post(url, options: dioo.Options(headers: {'cookie': header}));
      await fStorage.delete(key: 'cookie');
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      print('${header} heeeeeeeeeeeeeeeeeeyyyyyyy');
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

  Future<List<Place>> getPreApprovedPlaces() async {
    String url = 'http://192.168.8.105:3000/places/pre-approved-places';
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

  Future<List<Place>> getFavoritePlaces() async {
    String url = 'http://192.168.8.105:3000/places/favorite-places';
    dioo.Dio dio = dioo.Dio();
    FlutterSecureStorage fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    try {
      dioo.Response response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      List<dynamic> places = response.data;
      List<Place> favoritesList =
          places.map((place) => Place.fromJson(place)).toList();
      // favoriteList.forEach((element) {print(element.toJson());});
      return favoritesList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> postComment(String? comment, int? id) async {
    String url = 'http://192.168.8.105:3000/comments';
    dioo.Dio dio = dioo.Dio();
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? cookie = await storage.read(key: 'cookie');
    try {
      dio.post(url,
          data: {'comment': comment, 'place_id': id},
          options: dioo.Options(headers: {'cookie': cookie}));
    } catch (e) {
      throw e;
    }
  }

  Future<List<Comment>> getComments(int placeId) async {
    String url = 'http://192.168.8.105:3000/comments/$placeId';
    List<Comment> comments = [];
    dioo.Dio dio = dioo.Dio();
    final ListResult result = await Amplify.Storage.list(path: 'profilePics/');
    final List<StorageItem> items = result.items;
    try {
      dioo.Response response = await dio.get(
        url,
      );
      List<dynamic> jsonComments = response.data;
      comments =
          jsonComments.map((comment) => Comment.fromJson(comment)).toList();

      List<int> userIds = [];
      List<int> s3Ids = [];
      items.forEach((element) {
        String key = element.key;
        String sub = key.substring(12);
        s3Ids.add(int.parse(sub));
      });
      comments.forEach((element) => userIds.add(element.user!.user_id!));

      List<int> newList = [];
      int test = 0;
      s3Ids.forEach((s3Id) {
        test = userIds.firstWhere((userId) => s3Id == userId, orElse: () => 0);
        newList.add(test);
      });
      int id = 0;
      comments.forEach((comment) async {
        id = newList.firstWhere((element) => element == comment.user!.user_id);
        String dUrl = await getDownloadUrl(id);
        comment.user!.profilePic = dUrl;
      });
      print(newList);

      return comments;
    } catch (e) {
      throw e;
    }
  }

  Future<String> getDownloadUrl(int id) async {
    try {
      S3GetUrlOptions options =
          S3GetUrlOptions(accessLevel: StorageAccessLevel.guest);
      final GetUrlResult result = await Amplify.Storage.getUrl(
        key: 'profilePics/${id}',
        options: options,
      );
      // NOTE: This code is only for demonstration
      // Your debug console may truncate the printed url string
      print('Got URL: ${result.url}');
      return result.url;
    } on StorageException catch (e) {
      print('Error getting download URL: $e');
      throw e;
    }
  }

  // use getDownloadUrl inside listItems to save the list of urls together and use them anywhere

  Future<List<String>> listItems() async {
    List<String> urls = [];
    try {
      final ListResult result = await Amplify.Storage.list();
      final List<StorageItem> items = result.items;
      items.forEach(
        (element) async {
          String key = element.key;
          GetUrlResult foundItem = await Amplify.Storage.getUrl(key: key);
          String url = foundItem.url;
          urls.add(url);
        },
      );
      print('Got items: $urls');
      return urls;
    } on StorageException catch (e) {
      print('Error listing items: $e');
      throw e;
    }
  }

  Future<void> changeApprovalStatus(Place place) async {
    String url = 'http://192.168.8.105:3000/places/${place.place_id}';
    try {
      dioo.Dio dio = dioo.Dio();
      await dio.patch(url, data: place);
    } catch (e) {
      throw e;
    }
  }

  Future<void> PostImage(XFile image) async {
    String url = 'http://192.168.8.105:3000/places/photos';
    try {
      dioo.Dio dio = dioo.Dio();
      // List<int> imageBytes = await image.readAsBytes();
      // String baseImage = base64Encode(imageBytes);
      String fileName = image.path.split('/').last;
      dioo.FormData formData = dioo.FormData.fromMap({
        'image':
            await dioo.MultipartFile.fromFile(image.path, filename: fileName)
      });
      await dio.post(url, data: formData);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postPlace(Place place) async {
    String url = 'http://192.168.8.105:3000/places';
    var jsonObj = place.toJson();
    // print('${place.category!.categoryId} the function');
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response<dynamic> response = await dio.post(url, data: jsonObj);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<void> userFavorite(int id) async {
    String url = 'http://192.168.8.105:3000/users/favoritePlace/$id';
    dioo.Dio dio = dioo.Dio();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    print(header);
    try {
      dio.put(url, options: dioo.Options(headers: {'cookie': header}));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deletePlace(int id) async {
    String url = 'http://192.168.8.105:3000/places/$id';
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response response = await dio.delete(url);
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> getCities() async {
    String url = 'http://192.168.8.105:3000/cities';
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
    String url = 'http://192.168.8.105:3000/categories';
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
    String url = 'http://192.168.8.105:3000/neighborhoods?city_id=$city';
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
