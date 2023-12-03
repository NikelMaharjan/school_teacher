



class CoursePlan {
  int id;
  int course;
  String teachingDuration;
  String description;
  String expectedOutcome;
  DateTime createdAt;
  DateTime updatedAt;
  int schoolCollege;

  CoursePlan({
    required this.id,
    required this.course,
    required this.teachingDuration,
    required this.description,
    required this.expectedOutcome,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory CoursePlan.fromJson(Map<String, dynamic> json) {
    return CoursePlan(
      id: json['id'],
      course: json['course'] ,
      teachingDuration: json['teaching_duration'],
      description: json['description'],
      expectedOutcome: json['expected_outcome'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      schoolCollege: json['school_college'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'course': course,
    'teaching_duration': teachingDuration,
    'description': description,
    'expected_outcome': expectedOutcome,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'school_college': schoolCollege,
  };
}
