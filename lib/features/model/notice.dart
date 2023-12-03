import 'class_subject.dart';
import 'employee_info.dart';
import 'exam_model.dart';


class NoticeType {
  int id;
  String name;
  bool isSubType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic type;

  NoticeType({
    required this.id,
    required this.name,
    required this.isSubType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory NoticeType.fromJson(Map<String, dynamic> json) {
    return NoticeType(
      id: json['id'],
      name: json['name'],
      isSubType: json['is_sub_type'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      type: json['type'],
    );
  }
}



class NoticeData {
  final int id;
  final String title;
  final String description;
  final String? image;
  final bool forAllClass;
  final bool sendNotification;
  final String createdAt;
  final String updatedAt;
  final EmployeeData2? addedBy;
  final NoticeType? noticeType;

  NoticeData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.forAllClass,
    required this.sendNotification,
    required this.createdAt,
    required this.updatedAt,
    required this.addedBy,
    required this.noticeType,
  });

  factory NoticeData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError.notNull('json');
    }
    return NoticeData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'] ?? null,
      forAllClass: json['for_all_class'],
      sendNotification: json['send_notification'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      addedBy: json['added_by'] == null ? null : EmployeeData2.fromJson(json['added_by']),
      noticeType: json['notice_type'] == null ? null : NoticeType.fromJson(json['notice_type']),
    );
  }



}




class ClassNotice {
  final int id;
  final String createdAt;
  final String updatedAt;
  final ClassSection? classSection;
  final NoticeData notice;
  ClassNotice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.classSection,
    required this.notice,
  });

  factory ClassNotice.fromJson(Map<String, dynamic> json) {
    return ClassNotice(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      classSection: json['class_section']==null?ClassSection.fromJson(json['class_section']):null,
      notice: NoticeData.fromJson(json['notice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'class_section': classSection,
      'notice': notice,
    };
  }
}


class SubjectName{

  final int id;
  final Subject2 subjectName;

  SubjectName({
    required this.subjectName,
    required this.id
  });

  factory SubjectName.fromJson(Map<String, dynamic> json) {
    return SubjectName(
      id: json['id'],
      subjectName: Subject2.fromJson(json['status']),

    );
  }


}


class SubjectNotice {
  final int id;
  final String title;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClassSubject? subjectName;

  SubjectNotice({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.subjectName,
  });

  factory SubjectNotice.fromJson(Map<String, dynamic> json) {
    return SubjectNotice(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      subjectName: json['class_subject'] != null ? ClassSubject.fromJson(json['class_subject']) : null,
    );
  }


}