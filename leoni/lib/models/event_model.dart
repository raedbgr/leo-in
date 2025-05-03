class EventModel {
  final int id;
  final String name;
  final String image;
  final String location;
  final String region;
  final String department;
  final String details;
  final String schedule;
  final String objective;
  final DateTime dateB;
  final DateTime dateE;
  late bool isParticipated = false;

  EventModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
    required this.region,
    required this.department,
    required this.details,
    required this.schedule,
    required this.objective,
    required this.dateB,
    required this.dateE,
    this.isParticipated = false,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      image: json['img'],
      location: json['location'],
      region: json['region'],
      department: json['team'],
      details: json['details'],
      schedule: json['schedule'],
      objective: json['objective'],
      dateB: DateTime.parse(json['from']),
      dateE: DateTime.parse(json['to']),
    );
  }
}
