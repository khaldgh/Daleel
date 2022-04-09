import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/subcategory.dart';

class Place {
  final int? place_id;
  final String? title;
  final String? description;
  Category? category;
  final List<Subcategory>? subcategories;
  final List<Neighborhood>? neighborhoods;
  final bool? approved;
  final int? phone;
  final String? website;
  final String? instagram;
  final List<String>? weekdays;
  final List<dynamic>? images;

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
  });

  static Place fromJson(Map<String, dynamic> json) => Place(
        place_id: json['place_id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: Category(
            categoryId: json['category_id'], category: json['category']),
        neighborhoods: [
          Neighborhood(
              neighborhoodId: json['neighborhood_id'],
              neighborhood: json['neighborhood'])
        ],
        approved: json['approved'] == 0,
        phone: json['phone'] as int,
        website: json['website'] as String,
        instagram: json['instagram'] as String,
        images: json['images'] as List<dynamic>,
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
        'neighborhoods': neighborhoods!,
        'sunday': weekdays![0],
        'monday': weekdays![1],
        'tuesday': weekdays![2],
        'wednesday': weekdays![3],
        'thursday': weekdays![4],
        'friday': weekdays![5],
        'saturday': weekdays![6],
        // 'imageUrl': imageUrl!,
        // 'isFavorite': isFavorite! ? 1 : 0,
        // 'time': time!.toIso8601String(),
      };
}
