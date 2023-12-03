
import 'package:eschool_teacher/features/model/student.dart';

import 'class_subject.dart';
import 'employee_info.dart';

class Attendance {
  final int id;
  final String date;
  final bool forBachelorsClass;
  final ClassSection classSection;
  final EmployeeData2 addedBy;

  Attendance({
    required this.id,
    required this.date,
    required this.forBachelorsClass,
    required this.classSection,
    required this.addedBy,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      date: json['date'],
      forBachelorsClass: json['for_bachelors_class'],
      classSection: ClassSection.fromJson(json['class_section']),
      addedBy: EmployeeData2.fromJson(json['added_by']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'for_bachelors_class': forBachelorsClass,
      'class_section': classSection,
      'added_by': addedBy,
    };
  }
}

class StudentAttendance {
  final int id;
  final Attendance attendance;
  final Student2 student;
  final String status;

  StudentAttendance({
    required this.id,
    required this.attendance,
    required this.student,
    required this.status
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    return StudentAttendance(
        id: json['id'],
        attendance: Attendance.fromJson(json['attendance']),
        student: Student2.fromJson(json['student']),
        status: json['status']??null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendance': attendance,
      'student': student,
      'status':status
    };
  }
}



class StudentLeaveNote {
  int id;
  String? reason;
  bool? longLeave;
  String startDate;
  String? endDate;
  DateTime createdAt;
  DateTime updatedAt;
  Student2 student;

  StudentLeaveNote({
    required this.id,
    required this.reason,
    required this.longLeave,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
  });

  factory StudentLeaveNote.fromJson(Map<String, dynamic> json) {
    return StudentLeaveNote(
      id: json['id'],
      reason: json['reason']??'',
      longLeave: json['long_leave']??false,
      startDate: json['start_date'],
      endDate: json['end_date']??null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      student: Student2.fromJson(json['student']),
    );
  }

}