


import 'class_subject.dart';

class ExamType {
  int id;
  String name;
  bool isSubType;
  String createdAt;
  String updatedAt;
  dynamic type;

  ExamType({
    required this.id,
    required this.name,
    required this.isSubType,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory ExamType.fromJson(Map<String, dynamic> json) {
    return ExamType(
      id: json['id'],
      name: json['name'],
      isSubType: json['is_sub_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'is_sub_type': isSubType,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'type': type,
  };
}



class ExamDetail {
  final int id;
  final String name;
  final String examStartDate;
  final String examEndDate;
  final String examStatus;
  final ExamType examType;

  ExamDetail({
    required this.id,
    required this.name,
    required this.examStartDate,
    required this.examEndDate,
    required this.examStatus,
    required this.examType
  });

  factory ExamDetail.fromJson(Map<String, dynamic> json) {
    return ExamDetail(
        id: json['id'],
        name: json['name'],
        examStartDate: json['exam_start_date'],
        examEndDate: json['exam_end_date'],
        examStatus: json['exam_status'],
        examType: ExamType.fromJson(json['exam_type'])
    );
  }
}


class ExamClass {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ExamDetail exam;
  final ClassName examClass;


  ExamClass({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.exam,
    required this.examClass,

  });

  factory ExamClass.fromJson(Map<String, dynamic> json) {
    return ExamClass(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      exam: ExamDetail.fromJson(json['exam']),
      examClass: ClassName.fromJson(json['exam_class']),

    );
  }
}


class ExamRoutine {
  int id;
  String day;
  String startTime;
  String endTime;
  String date;
  ExamClass exam;
  Subject2 subject;


  ExamRoutine({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.exam,
    required this.subject,

  });

  factory ExamRoutine.fromJson(Map<String, dynamic> json) {
    return ExamRoutine(
      id: json['id'],
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      date: json['date'],
      exam: ExamClass.fromJson(json['exam']),
      subject: Subject2.fromJson(json['subject']),

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['date'] = this.date;
    data['exam'] = this.exam;
    data['subject'] = this.subject;

    return data;
  }
}



class Subject2{
  final int id;
  final String subjectName;
  final ClassName className;
  final String status;

  Subject2({
    required this.id,
    required this.subjectName,
    required this.className,
    required this.status
  });

  factory Subject2.fromJson(Map<String, dynamic> json) {
    return Subject2(
      id: json['id'],
      status: json['status'],
      className: ClassName.fromJson(json['class_name']),
      subjectName: json['subject_name'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'class_name': className.toJson(),
      'subject_name':status,
    };
  }


}