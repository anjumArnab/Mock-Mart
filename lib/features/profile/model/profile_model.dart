class ProfileModel {
  final int? id;
  final String? fName;
  final String? lName;
  final String? email;
  final String? phone;
  final String? image;
  final String? createdAt;

  ProfileModel({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.image,
    this.createdAt,
  });

  String get fullName => '${fName ?? ''} ${lName ?? ''}'.trim();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      fName: json['f_name'],
      lName: json['l_name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'phone': phone,
      'image': image,
      'created_at': createdAt,
    };
  }
}
