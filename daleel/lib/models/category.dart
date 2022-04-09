
class Category {

  int? categoryId;
  String? category;

  Category({this.categoryId, this.category});

  fromJson(Map<String, dynamic> json) => Category(
    categoryId: json['category_id'],
    category: json['category']
  );

  Map<String, Object> toJson() => {
    'category_id': categoryId!,
    'category': category!
  };

}