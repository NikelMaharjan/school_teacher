import 'package:eschool_teacher/features/model/employee_info.dart';
import 'package:eschool_teacher/features/model/school.dart';

import 'class_subject.dart';


class TeacherCourse {
  final ClassLevel classLevel;
  final String? classTeacher;

  TeacherCourse({required this.classLevel, required this.classTeacher});

  factory TeacherCourse.fromJson(Map<String, dynamic> json) {
    final classLevelJson = json['class_level'];
    final classLevel = ClassLevel.fromJson(classLevelJson);
    final classTeacher = json['class_teacher']??'';

    return TeacherCourse(classLevel: classLevel, classTeacher: classTeacher);
  }
}

class ClassLevel {
  final int id;
  final String sectionName;
  final ClassName className;

  ClassLevel({required this.id, required this.sectionName, required this.className});

  factory ClassLevel.fromJson(Map<String, dynamic> json) {
    final classNameJson = json['class_name'];
    final className = ClassName.fromJson(classNameJson);

    return ClassLevel(id: json['id'], sectionName: json['section_name'], className: className);
  }
}

class ClassName {
  final int id;
  final Batch batch;
  final Year year;
  final ClassLevelName classLevel;

  ClassName({required this.id, required this.batch, required this.year, required this.classLevel});

  factory ClassName.fromJson(Map<String, dynamic> json) {
    final batchJson = json['batch'];
    final batch = Batch.fromJson(batchJson);

    final yearJson = json['year'];
    final year = Year.fromJson(yearJson);

    final classLevelJson = json['class_level'];
    final classLevel = ClassLevelName.fromJson(classLevelJson);

    return ClassName(
      id: json['id'],
      batch: batch,
      year: year,
      classLevel: classLevel,
    );
  }
}

class Batch {
  final int id;
  final String batchName;

  Batch({required this.id, required this.batchName});

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(id: json['id'], batchName: json['batch_name']);
  }
}

class Year {
  final int id;
  final String yearName;

  Year({required this.id, required this.yearName});

  factory Year.fromJson(Map<String, dynamic> json) {
    return Year(id: json['id'], yearName: json['year_name']);
  }
}

class ClassLevelName {
  final int id;
  final String className;
  final String status;
  final bool isBachelorClass;

  ClassLevelName({required this.id, required this.className, required this.status, required this.isBachelorClass});

  factory ClassLevelName.fromJson(Map<String, dynamic> json) {
    return ClassLevelName(
      id: json['id'],
      className: json['class_name'],
      status: json['status'],
      isBachelorClass: json['is_bachelors_class'],
    );
  }
}


class TeacherClassCourse{

  final int id;
  final Courses courseName;
  final ClassLevel className;
  final EmployeeData teacher;

  TeacherClassCourse({
    required this.id,
    required this.className,
    required this.teacher,
    required this.courseName
});

  factory TeacherClassCourse.fromJson(Map<String, dynamic> json) {
    return TeacherClassCourse(
        id: json['id'],
        className: ClassLevel.fromJson(json['class_name']),
        teacher: EmployeeData.fromJson(json['teacher']),
        courseName: Courses.fromJson(json['course_name'])
    );
  }

}



