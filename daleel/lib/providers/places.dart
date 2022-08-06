import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:dio/dio.dart' as dioo;

import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/comment.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/screens/home_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import '../models/place.dart';

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

  List<Place> _favoriteList = [];

  List<Place> get favoriteList {
    return [..._favoriteList];
  }

  void openSnackBar(BuildContext context){
  final snackBar = SnackBar(
            content: const Text('الرجاء التأكد من الاتصال بالانترنت'),
            behavior: SnackBarBehavior.floating ,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
  }

  Future<Place> findById(int id) async {
    String url = 'https://daleel-app.herokuapp.com/places/findone/$id';
    String? cookie = await FlutterSecureStorage().read(key: 'cookie');
    List<String> urls = [];
    final ListResult result1 = await Amplify.Storage.list();
    final List<StorageItem> items = result1.items;
    final ListResult result2 = await Amplify.Storage.list(path: 'profilePics/');
    final List<StorageItem> items2 = result2.items;

    dioo.Dio dio = dioo.Dio();
    try {
      dioo.Response response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': cookie}));
      Place place = Place.fromJson(response.data);
      final ids = items
          .map((e) => e.key.split('/').length < 4
              ? 0
              : int.parse((e.key.split('/')[2])))
          .toList();
      ids.removeWhere((element) => element == 0);
      for (int index2 = 0; index2 < ids.length; index2++) {
        if (ids[index2] == place.place_id) {
          List<StorageItem> filteredItems = items
              .where((item) =>
                  item.key.split('/').length > 3 &&
                  int.parse(item.key.split('/')[2]) == ids[index2])
              .toList();
          List<String> keys = filteredItems.map((e) => e.key).toList();
          keys.removeAt(0);
          for (int index3 = 0; index3 < keys.length; index3++) {
            String downloadUrl = await imagesDownloadUrl(keys[index3]);
            if (urls.length < keys.length) urls.add(downloadUrl);
            /** future task: urls from aws s3 might change, which will add the same image to (urls).
               observed problem: when one of placeGrid's items was chosesn, returned to PlacesGrid then chose the same item again, the same images were repeated in
               the place.images List, ie. if the images were 2 they become 4. Two duplicates are added to place.images */

               //task done
          }
        }
      }
      StorageItem kUrl = items2.firstWhere(
        ((element) =>
            place.user!.user_id == int.parse(element.key.split('/')[1])),
        orElse: () => StorageItem(key: 'failed'),
      );
      String profilePic = await imagesDownloadUrl(kUrl.key);
      place.user!.profilePic = profilePic;
      place.images = urls;
      return place;
    } catch (e) {
      throw e;
    }
  }

  Place findByTitle(String title) {
    return _favoritePlaces.firstWhere(
        (place) => place.title?.toLowerCase() == title.toLowerCase());
  }

  List<Place> _favoritePlaces = [];

  List<Place> get favoritePlaces {
    return [..._favoritePlaces];
  }

  Future<List<Place>> getPlaces(
      {List<Category?> filteredList = const []}) async {
    dioo.Dio dio = dioo.Dio();
    String? header = await fStorage.read(key: 'cookie');
    String categoriesUrl = '';
    List<Category?> categories = await getUserPreferences();
    List<int?> userPrefs = filteredList.isNotEmpty
        ? filteredList.map((e) => e!.categoryId).toList()
        : categories.map((e) => e!.categoryId).toList();
    if (userPrefs.length == 1) {
      categoriesUrl = userPrefs[0].toString();
    } else if (userPrefs.length == 2) {
      String first = userPrefs.first.toString() + '%2C';
      String last = userPrefs.last.toString();
      categoriesUrl = first + last;
    } else {
      String first = userPrefs.first.toString() + '%2C';
      String last = userPrefs.last.toString();
      var middle = userPrefs.sublist(1, userPrefs.length - 1);
      middle.forEach((element) {
        categoriesUrl += element.toString() + '%2C';
      });
      categoriesUrl = first + categoriesUrl + last;
    }
    String url =
        'https://daleel-app.herokuapp.com/places/queryPlaces?categories=$categoriesUrl';

    try {
      final ListResult result = await Amplify.Storage.list(path: 'images');
      final List<StorageItem> items = result.items;
      dioo.Response<dynamic> response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header},));
      List places = response.data as List;
      List<Place> list = places.map((place) => Place.fromJson(place)).toList();
      final awsIds = items // finds ids of images from AWS
          .map((e) =>
              e.key.split('/').length < 4 ? 0 : int.parse(e.key.split('/')[2])).toSet()
          .toList();
      awsIds.removeWhere(
          (element) => element == 0); // removes all 0s from the previous step
          
         // looping through all places to attach every image from AWS to the right place
      for (int index1 = 0; index1 < list.length; index1++) {
        List<String> urls = [];
        for (int index2 = 0; index2 < awsIds.length; index2++) {
          if (awsIds[index2] == list[index1].place_id) {
            List<StorageItem> filteredItems = items
                .where((item) {
                  return item.key.split('/').length > 3 &&
                    int.parse(item.key.split('/')[2]) == awsIds[index2];
                })
                .toList();
            List<String> keys = filteredItems.map((e) => e.key).toList();
            keys.removeAt(0);
            for (int index3 = 0; index3 < keys.length; index3++) {
              String downloadUrl = await imagesDownloadUrl(keys[index3]);
              if (urls.length < keys.length) urls.add(downloadUrl);
            }
          }
        }
        list[index1].images = urls;
      }

      return list;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Place>> searchPlaces(String? phrase) async {
    String url = 'https://daleel-app.herokuapp.com/places/search/$phrase';
    dioo.Dio dio = dioo.Dio();
    final ListResult result = await Amplify.Storage.list(path: 'images');
      final List<StorageItem> items = result.items;
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? cookie = await storage.read(key: 'cookie');
    try {
      var response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': cookie}));
          List places = response.data as List;
      List<Place> list = places.map((place) => Place.fromJson(place)).toList();
      final awsIds = items // finds ids of images from AWS
          .map((e) =>
              e.key.split('/').length < 4 ? 0 : int.parse(e.key.split('/')[2])).toSet()
          .toList();
      awsIds.removeWhere(
          (element) => element == 0); // removes all 0s from the previous step
          
         // looping through all places to attach every image from AWS to the right place
      for (int index1 = 0; index1 < list.length; index1++) {
        List<String> urls = [];
        for (int index2 = 0; index2 < awsIds.length; index2++) {
          if (awsIds[index2] == list[index1].place_id) {
            List<StorageItem> filteredItems = items
                .where((item) {
                  return item.key.split('/').length > 3 &&
                    int.parse(item.key.split('/')[2]) == awsIds[index2];
                })
                .toList();
            List<String> keys = filteredItems.map((e) => e.key).toList();
            keys.removeAt(0);
            for (int index3 = 0; index3 < keys.length; index3++) {
              String downloadUrl = await imagesDownloadUrl(keys[index3]);
              if (urls.length < keys.length) urls.add(downloadUrl);
            }
          }
        }
        list[index1].images = urls;
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<void> getOffers() async {
    List<String> keys = [];
    List<String> offersUrl = [];
    final ListResult result =
        await Amplify.Storage.list(path: 'offers/سوبرماركت');
    final List<StorageItem> items = result.items;
    items.map(((e) {
      List<String> segmentedKey = e.key.split('/');
      segmentedKey.length == 3 ? keys.add(e.key.split('/')[2]) : 'wrong';
    })).toList();
    keys.removeAt(0);

    for (String key in keys) {
      for (int index = 0; index < items.length; index++) {
        String thirdSegment = items[index].key.split('/')[2];

        if (key == thirdSegment) {
          offersUrl.add(items[index].key);
        }
      }
    }
  }

  Future<String> imagesDownloadUrl(String? key) async {
    try {
      S3GetUrlOptions options =
          S3GetUrlOptions(accessLevel: StorageAccessLevel.guest);
      final GetUrlResult result = await Amplify.Storage.getUrl(
        key: key!,
        options: options,
      );
      // NOTE: This code is only for demonstration
      return result.url;
    } on StorageException catch (e) {
      throw e;
    }
  }

  Future<String> getDownloadUrl({String? folderName, int? id}) async {
    try {
      S3GetUrlOptions options =
          S3GetUrlOptions(accessLevel: StorageAccessLevel.guest);
      final GetUrlResult result = await Amplify.Storage.getUrl(
        key: '$folderName/${id}',
        options: options,
      );
      // NOTE: This code is only for demonstration
      return result.url;
    } on StorageException catch (e) {
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

  // bool? loggedIn;

  // String cookie = '';

  // Future<void> signin(
  //     String username, String password, BuildContext context) async {
  //   try {
  //     // String cookie = '';
  //     var url = 'https://daleel-app.herokuapp.com/users/signin';
  //     var storage = FlutterSecureStorage();
  //     var dio = dioo.Dio();
  //     var response =
  //         await dio.post(url, data: {'email': username, 'password': password});
  //     List<String>? cookies = response.headers['set-cookie'];
  //     String sub1 = cookies![0].substring(0, 30);
  //     String sub2 = cookies[1].substring(0, 45);
  //     cookie = sub1 + sub2;

  //     var write = await storage.write(key: 'cookie', value: cookie);
  //     loggedIn = true;
  //     // [express:sess=eyJ1c2VySWQiOjU1fQ==; path=/; httpsonly, express:sess.sig=Zy_Lc7kXM1BqZKIZRRt7ygpCTrM; path=/; httpsonly]
  //     Navigator.of(context).pushNamed(HomeScreen.routeName);
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  // Future<void> signup(String email, String username, String password,
  //     BuildContext context) async {
  //   try {
  //     var url = 'https://daleel-app.herokuapp.com/users/signup';
  //     var dio = dioo.Dio();
  //     var storage = FlutterSecureStorage();
  //     var response = await dio.post(
  //       url,
  //       data: {'email': email, 'username': username, 'password': password},
  //       options: dioo.Options(headers: {'Accept': 'application/json'})
  //     );
  //     List<String>? cookies = response.headers['set-cookie'];
  //     String sub1 = cookies![0].substring(0, 34);
  //     String sub2 = cookies[1].substring(0, 45);
  //     cookie = sub1 + sub2;

  //     await storage.write(key: 'cookie', value: cookie);

  //     response;
  //     loggedIn = true;
  //     Navigator.of(context).pushReplacementNamed(PreferencesScreen.routeName);
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  // Future<User> whoami() async {
  //   try {
  //     var url = 'https://daleel-app.herokuapp.com/users/whoami';
  //     var dio = dioo.Dio();
  //     var fStorage = FlutterSecureStorage();
  //     var header = await fStorage.read(key: 'cookie');
  //     var response = await dio.get(url,
  //         options: dioo.Options(headers: {'cookie': header}));
  //     return User.fromJson(response.data);
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  // Future<void> signout(BuildContext context) async {
  //   try {
  //     var url = 'https://daleel-app.herokuapp.com/users/signout';
  //     var dio = dioo.Dio();
  //     var fStorage = FlutterSecureStorage();
  //     var header = await fStorage.read(key: 'cookie');
  //     // await dio.post(url, options: dioo.Options(headers: {'cookie': header}));
  //     await fStorage.delete(key: 'cookie');
  //     Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  // Future<String?> cookies() async {
  //   var fStorage = FlutterSecureStorage();
  //   var storage = await fStorage.read(key: 'cookie');
  //   cookie = storage!;
  // }

  Future<List<Place>> getPreApprovedPlaces() async {
    String url = 'https://daleel-app.herokuapp.com/places/pre-approved-places';
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

  Future<List<Place>> getDayMostVisitedPlaces() async {
    String url = 'https://daleel-app.herokuapp.com/places/mostdayvisited';
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

  Future<List<Place>> getWeekMostVisitedPlaces() async {
    String url = 'https://daleel-app.herokuapp.com/places/mostweekvisited';
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

  Future<List<Place>>? getFavoritePlaces() async {
    String url = 'https://daleel-app.herokuapp.com/places/favorite-places';
    dioo.Dio dio = dioo.Dio();
    FlutterSecureStorage fStorage = FlutterSecureStorage();
    final ListResult result = await Amplify.Storage.list(path: 'images');
      final List<StorageItem> items = result.items;
      items.forEach((element) {
        print(element.key);
      });
    var header = await fStorage.read(key: 'cookie');
    try {
      dioo.Response response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      List<dynamic> places = response.data;
      List<Place> favoritesList =
          places.map((place) => Place.fromJson(place)).toList();
          final awsIds = items // finds ids of images from AWS
          .map((e) =>
              e.key.split('/').length < 4 ? 0 : int.parse(e.key.split('/')[2])).toSet()
          .toList();
          awsIds.removeWhere(
          (element) => element == 0); // removes all 0s from the previous step
      for (int index1 = 0; index1 < favoritesList.length; index1++) {
        List<String> urls = [];
        for (int index2 = 0; index2 < awsIds.length; index2++) {
          if (awsIds[index2] == favoritesList[index1].place_id) {
            List<StorageItem> filteredItems = items
                .where((item) =>
                    item.key.split('/').length > 3 &&
                    int.parse(item.key.split('/')[2]) == awsIds[index2]) // items in database & images in AWS must match or this will throw an error
                .toList();
            List<String> keys = filteredItems.map((e) => e.key).toList();
            keys.removeAt(0);
            for (int index3 = 0; index3 < keys.length; index3++) {
              String downloadUrl = await imagesDownloadUrl(keys[index3]);
              if (!urls.contains(downloadUrl)) urls.add(downloadUrl);
            }
          }
        }
        favoritesList[index1].images = urls;
        }
      return favoritesList;
    } catch (e) {
      throw e;
    }
  }

  Future<void> postComment(String? comment, int? id) async {
    String url = 'https://daleel-app.herokuapp.com/comments';
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
    String url = 'https://daleel-app.herokuapp.com/comments/$placeId';
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
        List<String> sub = key.split('/');
        List<String> spltKey = key.split('/');
        List<String> spltKey2 = spltKey[1].split('.');
        spltKey2.length < 1
            ? s3Ids.add(int.parse(sub[1]))
            : s3Ids.add(int.parse(spltKey2[0]));
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
        String dUrl = await getDownloadUrl(folderName: 'profilePics', id: id);
        comment.user!.profilePic = dUrl;
      });

      return comments;
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeApprovalStatus(Place place) async {
    String url = 'https://daleel-app.herokuapp.com/places/${place.place_id}';
    try {
      dioo.Dio dio = dioo.Dio();
      await dio.patch(url, data: place);
    } catch (e) {
      throw e;
    }
  }

  // List<Category> userPreferences = [];

  Future<void>  setUserPreferences(
      List<Category?> categories, BuildContext context, {bool? settingsScreen}) async {
    List<Map<String, Object>> jsonCategories = [];
    String url = 'https://daleel-app.herokuapp.com/users/preferences';
    dioo.Dio dio = dioo.Dio();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    categories.forEach((element) {
      jsonCategories.add(element!.toJson());
    });
    try {
      await dio.post(url,
          data: jsonCategories,
          options: dioo.Options(headers: {'cookie': header}));
          if(settingsScreen!) {
      Navigator.of(context).pop();      
          }
      Navigator.of(context).pushNamed(HomeScreen.routeName);
      // return response;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Category>> getUserPreferences() async {
    List<Category> fromJsonCategories = [];
    String url = 'https://daleel-app.herokuapp.com/users/preferences';
    dioo.Dio dio = dioo.Dio();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    try {
      dioo.Response<dynamic> response = await dio.get(url,
          options: dioo.Options(headers: {'cookie': header}));
      List<dynamic> resData = response.data;
      resData.forEach(
          ((element) => fromJsonCategories.add(Category().fromJson(element))));
      return fromJsonCategories;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postPlace(Place place) async {
    String url = 'https://daleel-app.herokuapp.com/places';
    var jsonObj = place.toJson();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    try {
      dioo.Dio dio = dioo.Dio();
      dioo.Response<dynamic> response = await dio.post(url,
          data: jsonObj, options: dioo.Options(headers: {'cookie': header}));
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<void> userFavorite(int id) async {
    String url = 'https://daleel-app.herokuapp.com/users/favoritePlace/$id';
    dioo.Dio dio = dioo.Dio();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    try {
      dio.post(url, options: dioo.Options(headers: {'cookie': header}));
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeFavorite(int id) async {
    String url = 'https://daleel-app.herokuapp.com/users/favoritePlace/$id';
    dioo.Dio dio = dioo.Dio();
    var fStorage = FlutterSecureStorage();
    var header = await fStorage.read(key: 'cookie');
    try {
      dio.delete(url, options: dioo.Options(headers: {'cookie': header}));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deletePlace(int id) async {
    String url = 'https://daleel-app.herokuapp.com/places/$id';
    try {
      dioo.Dio dio = dioo.Dio();
      await dio.delete(url);
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> getCities() async {
    String url = 'https://daleel-app.herokuapp.com/cities';
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
      return cities.reversed.toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Category>> getCategories() async {
    String url = 'https://daleel-app.herokuapp.com/categories';
    Category category = Category();
    dioo.Dio dio = dioo.Dio();
    List<Category> categories = [];
    try {
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((cat) => categories.add(category.fromJson(cat)));
      return categories.toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<Category>> getBigCategories() async {
    String url = 'https://daleel-app.herokuapp.com/categories/bigCategories';
    Category category = Category();
    dioo.Dio dio = dioo.Dio();
    List<Category> categories = [];
    try {
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((cat) => categories.add(category.fromJson(cat)));
      return categories.toList();
    } catch (e) {
      throw e;
    }
  }

  List<Neighborhood>? neighborhoods = [];
  Future<List<Neighborhood>> neighborhoodQuery(int city) async {
    String url = 'https://daleel-app.herokuapp.com/neighborhoods?city_id=$city';
    dioo.Dio dio = dioo.Dio();
    try {
      if (neighborhoods!.isNotEmpty) neighborhoods!.clear();
      dioo.Response response = await dio.get(url);
      List<dynamic> data = response.data;
      data.forEach((key) => neighborhoods!.add(Neighborhood().fromJson(key)));
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
    bool findPlace = formPlaces.any((element) => element.place_id == id);
    if (findPlace) {
      Place place = formPlaces.firstWhere((element) => element.place_id == id);
      return place;
    } else {
      throw Exception('place not found');
    }
  }
}
