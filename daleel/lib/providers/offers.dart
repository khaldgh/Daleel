import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../models/offer.dart';

class Offers with ChangeNotifier {
  List<Offer> _offers = [
    Offer(title: Text('سوبرماركت', style: TextStyle(color: Colors.white)), icon: Icon(Icons.shopping_cart_outlined, color: Color(0xFF40D8AB),size: 30,)),
    Offer(title: Text('الكترونيات', style: TextStyle(color: Colors.white)), icon: Icon(Icons.phonelink, color: Color(0xFF40D8AB),size: 30,)),
    Offer(title: Text('سيارات', style: TextStyle(color: Colors.white)), icon: Icon(Icons.directions_car, color: Color(0xFF40D8AB),size: 30,)),
    Offer(title: Text('مطاعم', style: TextStyle(color: Colors.white)), icon: Icon(Icons.restaurant_menu, color: Color(0xFF40D8AB),size: 30,)),
    Offer(title: Text('مقاهي', style: TextStyle(color: Colors.white)), icon: Icon(Icons.free_breakfast, color: Color(0xFF40D8AB),size: 30,)),
  ];

  Future<List<File>> offerFiles() async {
    final ListResult result =
        await Amplify.Storage.list(path: 'offers/سوبرماركت');
    final List<StorageItem> items = result.items;

    List<String> keys = [];

    List<String> urls = [];

    List<File> files = [];

    for (int i = 0; i < items.length; i++) {
      String itemIndex = items[i].key;
      if (!keys.contains(itemIndex)) {
        keys.add(itemIndex);
      }
    }

    keys.removeAt(0);
    

    for (int i = 0; i < keys.length; i++) {
    GetUrlResult urlResult = await Amplify.Storage.getUrl(key: keys[i]);
    String url = urlResult.url;
    urls.add(url);
    }



    for (int i = 0; i < urls.length; i++) {
      print('$i index');
      File file = await DefaultCacheManager().getSingleFile(urls[0]);
      print('object');
      files.add(file);
    }

    print(files[0]);
    
    return files;
  }

  List<Offer> get offers {
    return [..._offers];
  }
}
