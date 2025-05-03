class HolidayModel {
  final String name;
  final DateTime date;

  HolidayModel({required this.name, required this.date});

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      name: json['name'],
      date: DateTime.parse(json['date']),
    );
  }
}
