class NotificationModel {
  final String userId;
  final String notif_type;
  final String content;
  final DateTime timestamp;
  final int typeId;

  NotificationModel({
    required this.userId,
    required this.notif_type,
    required this.content,
    required this.timestamp,
    required this.typeId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      userId: json['userId'],
      notif_type: json['notif_type'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      typeId: json['typeId'],
    );
  }
}
