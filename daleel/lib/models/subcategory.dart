
class Subcategory {

  int? subcategoryId;
  String? subcategory;

  Subcategory({this.subcategoryId, this.subcategory});

  fromJson(Map<String, dynamic> json) => Subcategory(
    subcategoryId: json['subcategory_id'],
    subcategory: json['subcategory']
  );

  Map<String, Object> toJson() => {
    'subcategory_id': subcategoryId!,
    'subcategory': subcategory!
  };

}