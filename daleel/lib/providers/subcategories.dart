import 'package:daleel/models/subcategory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Subcategories with ChangeNotifier {

  Future<List<String>> getSubcategoriesOfSingleCategory(int categoryId) async {
    List<String> subcategories = [];
    try {
      var url = 'http://192.168.68.107/subcategories/$categoryId';
      var dio = Dio();
      var response = await dio.get(url);
      List<dynamic> subcats = response.data;
      for (int index = 0; index < subcats.length; index++) {
        Subcategory jsonSubcat = Subcategory().fromJson(subcats[index]);
        print(jsonSubcat.subcategory);
        if (!subcategories.contains(jsonSubcat.subcategory!)) {
          subcategories.add(jsonSubcat.subcategory!);
        }
      }
      return subcategories;
    } catch (err) {
      throw err;
    }
  }

  Future<List<String>> getSubcategoriesOfSinglePlace(int placeId) async {
    List<String> subcategories = [];
    try {
      var url = 'http://192.168.68.107/subcategories/place/$placeId';
      var dio = Dio();
      var response = await dio.get(url);
      List<dynamic> subcats = response.data;
      for (int index = 0; index < subcats.length; index++) {
        Subcategory jsonSubcat = Subcategory().fromJson(subcats[index]);
        print(jsonSubcat.subcategory);
        if (!subcategories.contains(jsonSubcat.subcategory!)) {
          subcategories.add(jsonSubcat.subcategory!);
        }
      }
      return subcategories;
    } catch (err) {
      throw err;
    }
  }
}
