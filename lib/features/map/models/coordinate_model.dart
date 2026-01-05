class CoordinateModel {
  int id;
  String name;
  String email;
  String longitude;
  String latitude;
  String address;
  int coverage;
  int status;

  CoordinateModel({
    required this.id,
    required this.name,
    required this.email,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.coverage,
    required this.status,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) {
    return CoordinateModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      address: json['address'],
      coverage: json['coverage'],
      status: json['status'],
    );
  }
}
