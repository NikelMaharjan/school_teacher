class RoutineData {
  int id;
  String day;
  String startTime;
  String endTime;
  String createdAt;
  String updatedAt;
  int classSubject;
  int schoolCollege;

  RoutineData({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.classSubject,
    required this.schoolCollege,
  });

  factory RoutineData.fromJson(Map<String, dynamic> json) => RoutineData(
    id: json['id'],
    day: json['day'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    classSubject: json['class_subject'],
    schoolCollege: json['school_college'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'day': day,
    'start_time': startTime,
    'end_time': endTime,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'class_subject': classSubject,
    'school_college': schoolCollege,
  };
}
