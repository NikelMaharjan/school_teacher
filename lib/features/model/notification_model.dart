class NotificationModel {
  int id;
  String title;
  String body;
  String notificationType;
  int objectId;
  bool seen;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.notificationType,
    required this.objectId,
    required this.seen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      notificationType: json['notification_type'],
      objectId: json['object_id'],
      seen: json['seen'],
    );
  }

}
