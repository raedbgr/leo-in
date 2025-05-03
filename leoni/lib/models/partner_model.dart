class PartnerModel {
  final int? id;
  final String name;
  final String category;
  final String imagePath;
  final String address;
  final String phone;
  final String email;
  final String description;
  final String offers;
  final String? website;
  final String? facebook;
  final String? instagram;
  final int? totalLikes;
  late bool isLiked = false;

  PartnerModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
    required this.offers,
    required this.website,
    required this.facebook,
    required this.instagram,
    this.totalLikes,
    this.isLiked = false,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'] as int?,
      name: json['name'],
      category: json['category'],
      imagePath: json['img'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      description: json['description'],
      offers: json['offre'],
      website: json['web'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      totalLikes: json['total_likes'],
    );
  }
}
