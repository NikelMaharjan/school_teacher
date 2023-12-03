
import 'employee_info.dart';


class AttendanceDateTeacher {
  final int id;
  final DateTime date;

  AttendanceDateTeacher({
    required this.id,
    required this.date,
  });

  factory AttendanceDateTeacher.fromJson(Map<String, dynamic> json) {
    return AttendanceDateTeacher(
      id: json['id'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
    };
  }
}


class TeacherAttendance {
  final int id;
  final AttendanceDateTeacher attendance;
  final EmployeeData2 employee;
  final String status;

  TeacherAttendance({
    required this.id,
    required this.attendance,
    required this.employee,
    required this.status,
  });

  factory TeacherAttendance.fromJson(Map<String, dynamic> json) {
    return TeacherAttendance(
      id: json['id'],
      attendance:AttendanceDateTeacher.fromJson(json['attendance']),
      employee: EmployeeData2.fromJson(json['employee']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attendance': attendance.toJson(),
      'employee': employee.toJson(),
      'status': status,
    };
  }
}

class TeacherLeaveNote {
  int id;
  String? reason;
  bool? longLeave;
  String startDate;
  String? endDate;
  DateTime createdAt;
  DateTime updatedAt;
  EmployeeData2 employee;

  TeacherLeaveNote({
    required this.id,
    required this.reason,
    required this.longLeave,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.employee,
  });

  factory TeacherLeaveNote.fromJson(Map<String, dynamic> json) {
    return TeacherLeaveNote(
      id: json['id'],
      reason: json['reason']??'',
      longLeave: json['long_leave']??false,
      startDate: json['start_date'],
      endDate: json['end_date']??null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      employee: EmployeeData2.fromJson(json['employee']),
    );
  }

}
