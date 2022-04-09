
class Subcategory {

  int? subcategoryId;
  String? subcategory;

  Subcategory({this.subcategoryId, this.subcategory});

  fromJson(Map<String, dynamic> json) => Subcategory(
    subcategoryId: json['sub_category_id'],
    subcategory: json['sub_category']
  );

  Map<String, Object> toJson() => {
    'sub_category_id': subcategoryId!,
    'sub_category': subcategory!
  };

}