
class City {

  int? cityId;
  String? city;

  City({this.cityId, this.city});

  fromJson(Map<String, dynamic> json) => City(
    cityId: json['city_id'],
    city: json['city']
  );

  Map<String, Object> toJson() => {
    'city_id': cityId!,
    'city': city!
  };

}