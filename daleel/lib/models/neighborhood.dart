
class Neighborhood {

  int? neighborhoodId;
  String? neighborhood;
  int? cityId;
  String? city;

  Neighborhood({this.neighborhoodId, this.neighborhood, this.cityId, this.city});

  fromJson(Map<String, dynamic> json) => Neighborhood(
    neighborhoodId: json['neighborhood_id'],
    neighborhood: json['neighborhood'],
    cityId: json['city_id'],
    city: json['city'],  
  );

  Map<String, Object> toJson() => {
    'neighborhood_id': neighborhoodId!,
    'neighborhood': neighborhood!,
    // 'city_id': cityId!,
    // 'city': city!
  };

}