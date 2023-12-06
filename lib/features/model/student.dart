import 'class_subject.dart';

class Student {
  final int id;
  final String studentName;
  final String gender;
  final String residentalAddress;
  final String nationality;
  final String mobileNumber;
  final String homeTel;
  final String email;
  final String dateOfBirthEng;
  final String dateOfBirthNep;
  final int age;
  final String religion;
  final String fatherName;
  final String motherName;
  final String fatherPhoneNumber;
  final String motherPhoneNumber;
  final String seeSchoolName;
  final String seeSymbolNumber;
  final String seeBoard;
  final String seeGpa;
  final int seePassedYear;
  final String slcSchoolName;
  final String slcAddress;
  final String slcBoard;
  final String slcGpa;
  final String slcDivision;
  final String slcPassedYear;
  final String latestPassedClass;
  final String latestPassedClassGpa;
  final String prevSchoolName;
  final String? preSchoolAddress;
  final String? hobbies;
  final String? guardianName;
  final String? guardianRelation;
  final String? studentPhoto;
  final bool? systemUser;
  final String? createdAt;
  final String? updatedAt;

  // final int school;

  Student({
    required this.id,
    required this.studentName,
    required this.gender,
    required this.residentalAddress,
    required this.nationality,
    required this.mobileNumber,
    required this.homeTel,
    required this.email,
    required this.dateOfBirthEng,
    required this.dateOfBirthNep,
    required this.age,
    required this.religion,
    required this.fatherName,
    required this.motherName,
    required this.fatherPhoneNumber,
    required this.motherPhoneNumber,
    required this.seeSchoolName,
    required this.seeSymbolNumber,
    required this.seeBoard,
    required this.seeGpa,
    required this.seePassedYear,
    required this.slcSchoolName,
    required this.slcAddress,
    required this.slcBoard,
    required this.slcGpa,
    required this.slcDivision,
    required this.slcPassedYear,
    required this.latestPassedClass,
    required this.latestPassedClassGpa,
    required this.prevSchoolName,
    required this.preSchoolAddress,
    required this.hobbies,
    required this.guardianName,
    required this.guardianRelation,
    required this.studentPhoto,
    required this.systemUser,
    required this.createdAt,
    required this.updatedAt,
    // required this.school,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      studentName: json['student_name'] ?? '',
      gender: json['gender'] ?? '',
      residentalAddress: json['residental_address'] ?? '',
      nationality: json['nationality'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      homeTel: json['home_tel'] ?? '',
      email: json['email'] ?? '',
      dateOfBirthEng: json['date_of_birth_eng'] ?? '',
      dateOfBirthNep: json['date_of_birth_nep'] ?? '',
      age: json['age'] ?? '',
      religion: json['religion'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      fatherPhoneNumber: json['father_phone_number'] ?? '',
      motherPhoneNumber: json['mother_phone_number'] ?? '',
      seeSchoolName: json['see_school_name'] ?? '',
      seeSymbolNumber: json['see_symbol_number'] ?? '',
      seeBoard: json['see_board'] ?? '',
      seeGpa: json['see_gpa'] ?? '',
      seePassedYear: json['see_passed_year'] ?? '',
      slcSchoolName: json['slc_school_name'] ?? '',
      slcAddress: json['slc_address'] ?? '',
      slcBoard: json['slc_board'] ?? '',
      slcGpa: json['slc_gpa'] ?? '',
      slcDivision: json['slc_division'] ?? '',
      slcPassedYear: json['slc_passed_year'] ?? '',
      latestPassedClass: json['latest_passed_class'] ?? '',
      latestPassedClassGpa: json['latest_passed_class_gpa'] ?? '',
      prevSchoolName: json['prev_school_name'] ?? '',
      preSchoolAddress: json['pre_school_address'] ?? '',
      hobbies: json['hobbies'] ?? '',
      guardianName: json['guardian_name'] ?? '',
      guardianRelation: json['guardian_relation'] ?? '',
      studentPhoto: json['student_photo'] ?? '',
      systemUser: json['create_system_user'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      // school: json['school_college']??'',
    );
  }

}

class StudentClass {
  int id;
  int rollNo;
  Student2 student;
  ClassSection className;
  bool currentLevel;

  StudentClass({
    required this.id,
    required this.rollNo,
    required this.student,
    required this.className,
    required this.currentLevel
  });

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      id: json['id'],
      rollNo: json['roll_no'],
      currentLevel: json['current_level'],
      student: Student2.fromJson(json['student']),
      className: ClassSection.fromJson(json['class_name']),
    );
  }


}



class Student2 {
  final int id;
  final String studentName;
  final String? studentPhoto;
  final String gender;
  final String residental_address;
  final int mobile_number;
  final String father_name;
  final String mother_name;
  final String email;
  final String date_of_birth_eng;
  final String student_roll_no;





  Student2({
    required this.id,
    required this.studentName,
    required this.studentPhoto,
    required this.mother_name,
    required this.father_name,
    required this.email,
    required this.student_roll_no,
    required this.mobile_number,
    required this.residental_address,
    required this.gender,
    required this.date_of_birth_eng


  });

  factory Student2.fromJson(Map<String, dynamic> json) {
    return Student2(
      id: json['id'] ?? '',
      studentName: json['student_name'] ?? '',
      mother_name: json['mother_name'] ?? '',
      father_name: json['father_name'] ?? '',
      email: json['email'] ?? '',
      student_roll_no: json['student_roll_no'] ?? '',
      mobile_number: json['mobile_number'] ?? '',
      residental_address: json['residental_address'] ?? '',
      gender: json['gender'] ?? '',
      date_of_birth_eng: json['date_of_birth_eng'] ?? '',

      studentPhoto: json['student_photo'] ?? null,

    );
  }

}
