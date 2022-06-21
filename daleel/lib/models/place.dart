import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/subcategory.dart';
import 'package:daleel/models/user.dart';

class Place {
   int? place_id;
  final String? title;
  final String? description;
  final Category? category;
  final List<Subcategory>? subcategories;
  final List<Neighborhood>? neighborhoods;
   bool? approved;
  final int? phone;
  final String? website;
  final String? instagram;
  final List<String>? weekdays;
   List<String>? images;
  final User? user;

  Place({
    this.place_id,
    this.title,
    this.description,
    this.category,
    this.subcategories,
    this.neighborhoods,
    this.approved,
    this.phone,
    this.website,
    this.instagram,
    this.weekdays,
    this.images,
    this.user
  });

  static Place fromJson(Map<String, dynamic> json) => Place(
        place_id: json['place_id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: Category(
            categoryId: json['category_id'], category: json['category']),
        neighborhoods: [
          Neighborhood(
            neighborhoodId: json['neighborhoods'][0]['neighborhood_id'],
            neighborhood: json['neighborhoods'][0]['neighborhood'],
            cityId: json['neighborhoods'][0]['city_id'],
            city: json['neighborhoods'][0]['city'],
          )
        ],
        approved: json['approved'] == 0,
        phone: json['phone'] as int,
        website: json['website'] as String,
        instagram: json['instagram'] as String,
        user: User(
          user_id: json['user_id'],
          username: json['username'],
          email: json['email'],
        ),
        images: [],
        weekdays: [
          json['Sunday'],
          json['monday'],
          json['tuesday'],
          json['wednesday'],
          json['thursday'],
          json['friday'],
          json['saturday']
        ],
      );

  Map<String, Object> toJson() => {
        // 'id': id!,
        'title': title!,
        'description': description!,
        'category': category!,
        'approved': approved!,
        'phone': phone!,
        'website': website!,
        'instagram': instagram!,
        'images': images!,
        // 'user': user!,
        'neighborhoods': neighborhoods!,
        'Sunday': weekdays![0],
        'Monday': weekdays![1],
        'Tuesday': weekdays![2],
        'Wednesday': weekdays![3],
        'Thursday': weekdays![4],
        'Friday': weekdays![5],
        'Saturday': weekdays![6],
      };
}
