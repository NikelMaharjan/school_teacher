

import 'class_subject.dart';

class TeacherClass {

  ClassSection classSection;

  TeacherClass({required this.classSection});

  factory TeacherClass.fromJson(Map<String, dynamic> json) {
    return TeacherClass(

      classSection: ClassSection.fromJson(json['class_section']),
    );
  }



  @override
  String toString() {
    // TODO: implement toString
    return '${classSection.className.classLevel.name}${classSection.section.sectionName}';
  }
}

class TeacherRoutine{

  final List<ClassRoutine> classRoutine;
  final ClassSection classSection;

  TeacherRoutine({required this.classSection,required this.classRoutine});

  factory TeacherRoutine.fromJson(Map<String, dynamic> json) {
    return TeacherRoutine(
        classRoutine: ClassRoutine.listFromJson(json['class_routine']),
        classSection: ClassSection.fromJson(json['class_section'])
    );
  }


}

class ClassRoutine {
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClassSecSubject classSubject;
  final int schoolCollege;

  ClassRoutine({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.classSubject,
    required this.schoolCollege,
  });

  factory ClassRoutine.fromJson(Map<String, dynamic> json) {
    return ClassRoutine(
      id: json['id'],
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      classSubject: ClassSecSubject.fromJson(json['class_subject']),
      schoolCollege: json['school_college'],
    );
  }

  static List<ClassRoutine> listFromJson(List<dynamic> json) {
    return json.map((routine) => ClassRoutine.fromJson(routine)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'class_subject': classSubject,
      'school_college': schoolCollege,
    };
  }
}


