
class Neighborhood {

  int? neighborhoodId;
  String? neighborhood;

  Neighborhood({this.neighborhoodId, this.neighborhood});

  fromJson(Map<String, dynamic> json) => Neighborhood(
    neighborhoodId: json['neighborhood_id'],
    neighborhood: json['neighborhood']
  );

  Map<String, Object> toJson() => {
    'neighborhood_id': neighborhoodId!,
    'neighborhood': neighborhood!
  };

}