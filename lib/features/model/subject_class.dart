
import 'package:eschool_teacher/features/model/class_subject.dart';

class SubjectPlan {
  int id;
  ClassSubject? classSubject;
  String teachingDuration;
  String description;
  String expectedOutcome;
  DateTime createdAt;
  DateTime updatedAt;

  SubjectPlan({
    required this.id,
    required this.classSubject,
    required this.teachingDuration,
    required this.description,
    required this.expectedOutcome,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubjectPlan.fromJson(Map<String, dynamic> json) {
    return SubjectPlan(
      id: json['id'],
      classSubject: json['class_subject'] == null ? null : ClassSubject.fromJson(json['class_subject']),
      teachingDuration: json['teaching_duration'],
      description: json['description'],
      expectedOutcome: json['expected_outcome'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject': classSubject?.toJson(),
    'teaching_duration': teachingDuration,
    'description': description,
    'expected_outcome': expectedOutcome,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class SubjectDetails {
  int id;
  Subject subject;

  SubjectDetails({
    required this.id,
    required this.subject,
  });

  factory SubjectDetails.fromJson(Map<String, dynamic> json) {
    return SubjectDetails(
      id: json['id'],
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject': subject.toJson(),
  };
}

class Subject {
  int id;
  String subjectName;

  Subject({
    required this.id,
    required this.subjectName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      subjectName: json['subject_name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_name': subjectName,
  };
}

