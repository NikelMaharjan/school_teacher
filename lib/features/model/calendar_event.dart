
class CalendarEvent {
  final int id;
  final String dateEng;
  String? dateNepali;
  final String title;
  final String location;
  final String description;
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;
  final EventType event_type;


  CalendarEvent({
    required this.id,
    required this.event_type,
    required this.dateEng,
    required this.dateNepali,
    required this.title,
    required this.location,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      dateEng: json['date_eng'],
      dateNepali: json['date_nepali'] ?? "",
      title: json['title'],
      location: json['location'],
      description: json['description'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      event_type: EventType.fromJson(json['event_type']),
    );
  }

// Map<String, dynamic> toJson() {
//   return {
//     'id': id,
//     'date_eng': dateEng,
//     'date_nepali': dateNepali,
//     'title': title,
//     'location': location,
//     'description': description,
//     'start_time': startTime,
//     'end_time': endTime,
//     'created_at': createdAt,
//     'updated_at': updatedAt,
//   };
// }
}






class EventType {
  final int id;
  final String name;
  final bool is_sub_type;
  final String? type;

  final String created_at;
  final String updated_at;

  EventType(
      {required this.id,
        required this.name,
        required this.is_sub_type,
        required this.type,
        required this.created_at,
        required this.updated_at});

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      created_at: json['created_at'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      is_sub_type: json['is_sub_type'] ?? '',
      type: json['type'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }
}

class SubType {
  final int id;
  final String name;
  final bool is_sub_type;
  final String status;
  final String created_at;
  final String updated_at;
  final int type;
  final int school;

  SubType(
      {required this.created_at,
        required this.id,
        required this.school,
        required this.type,
        required this.is_sub_type,
        required this.updated_at,
        required this.status,
        required this.name});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
        created_at: json['created_at'] ?? '',
        id: json['id'] ?? '',
        school: json['school'] ?? '',
        type: json['type'] ?? '',
        is_sub_type: json['is_sub_type'] ?? '',
        updated_at: json['updated_at'] ?? '',
        status: json['status'] ?? '',
        name: json['name'] ?? '');
  }
}