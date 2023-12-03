import 'dart:io';

import 'package:eschool_teacher/features/model/student.dart';

import 'class_subject.dart';






class Assignment {
  final int id;
  final String title;
  final String description;
  final bool hasDeadline;
  final String? deadline;
  final String? link;
  final String? imageFile;
  final String assignmentType;
  final String createdAt;
  final String updatedAt;
  final ClassSubject classSubject;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.hasDeadline,
    required this.deadline,
    required this.link,
    required this.imageFile,
    required this.assignmentType,
    required this.createdAt,
    required this.updatedAt,
    required this.classSubject,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      hasDeadline: json['has_deadline'],
      deadline: json['deadline']??null,
      link: json['link']??null,
      imageFile: json['image_file']??null,
      assignmentType: json['assignment_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      classSubject: ClassSubject.fromJson(json['class_subject']),
    );
  }

}



class StudentAssignment {
  int id;
  File studentAssignment;
  String createdAt;
  String updatedAt;
  Assignment assignment;
  Student2 student;

  StudentAssignment({
    required this.id,
    required this.studentAssignment,
    required this.createdAt,
    required this.updatedAt,
    required this.assignment,
    required this.student,
  });

  factory StudentAssignment.fromJson(Map<String, dynamic> json) {
    return StudentAssignment(
      id: json['id'],
      studentAssignment: File(json['student_assignment']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      assignment: Assignment.fromJson(json['assignment']),
      student: Student2.fromJson(json['student']),
    );
  }

}

class StudentAssignmentStatus {
  int id;
  String status;
  String remarks;
  bool sendNotification;
  String createdAt;
  String updatedAt;
  StudentAssignment studentAssignment;

  StudentAssignmentStatus({
    required this.id,
    required this.status,
    required this.remarks,
    required this.sendNotification,
    required this.createdAt,
    required this.updatedAt,
    required this.studentAssignment,
  });

  factory StudentAssignmentStatus.fromJson(Map<String, dynamic> json) {
    return StudentAssignmentStatus(
      id: json['id'],
      status: json['status'],
      remarks: json['remarks'],
      sendNotification: json['send_notification'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      studentAssignment: StudentAssignment.fromJson(json['student_assignment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'remarks': remarks,
      'send_notification': sendNotification,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'student_assignment': studentAssignment,
    };
  }
}