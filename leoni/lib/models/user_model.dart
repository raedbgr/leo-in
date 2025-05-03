class UserModel {
  final String name;
  final String uniqueName;
  final String imagePath;
  final bool isAdmin;
  final String region;
  final String department;
  final String team;
  final String post;
  final String bio;
  final String skills;
  final String hobbies;
  final String langs;

  UserModel(
      {
      required this.name,
      required this.uniqueName,
      required this.imagePath,
      required this.isAdmin,
      required this.region,
      required this.department,
      required this.team,
      required this.post,
      required this.bio,
      required this.skills,
      required this.hobbies,
      required this.langs});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uniqueName: json['email'],
      name: json['full_name'],
      imagePath: json['image_path'],
      isAdmin: json['is_admin'] == 1,
      region: json['region'],
      team: json['team'],
      department: json['department'],
      post: json['post'],
      bio: json['user_bio'],
      skills: json['user_skills'],
      hobbies: json['user_hobbies'],
      langs: json['user_lang'],
    );
  }
}
