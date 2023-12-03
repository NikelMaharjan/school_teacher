class EmployeeData {
  final int id;
  final String name;
  final String current_address;
  final String permanent_address;
  final String mobile_no;
  final String email;
  final String picture;
  final String salary;
  final String gender;
  final String blood_group;
  final String allergies;
  final String experience;
  final String religion;
  final String education;
  final String father_name;
  final String mother_name;
  final String father_phone_no;
  final String mother_phone_no;
  final String employee_photo;
  final String employee_type;

  EmployeeData({
    required this.id,
    required this.email,
    required this.allergies,
    required this.blood_group,
    required this.current_address,
    required this.education,
    required this.employee_photo,
    required this.employee_type,
    required this.experience,
    required this.father_name,
    required this.father_phone_no,
    required this.name,
    required this.gender,
    required this.mobile_no,
    required this.mother_name,
    required this.mother_phone_no,
    required this.permanent_address,
    required this.picture,
    required this.religion,
    required this.salary,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      allergies: json['allergies'] ?? '',
      blood_group: json['blood_group'] ?? '',
      current_address: json['current_address'] ?? '',
      education: json['education'] ?? '',
      employee_photo: json['employee_photo'] ?? '',
      employee_type: json['employee_type'] ?? '',
      experience: json['experience'] ?? '',
      father_name: json['father_name'] ?? '',
      father_phone_no: json['father_phone_no'] ?? '',
      name: json['employee_name'] ?? '',
      gender: json['gender'] ?? '',
      mobile_no: json['mobile_no'] ?? '',
      mother_name: json['mother_name'] ?? '',
      mother_phone_no: json['mother_phone_no'] ?? '',
      permanent_address: json['permanent_address'] ?? '',
      picture: json['picture'] ?? '',
      religion: json['religion'] ?? '',
      salary: json['salary'] ?? '',
    );
  }
}


class EmployeeData2 {
  final int id;
  final String employeeName;
  final String? employee_photo;


  EmployeeData2({
    required this.id,
    required this.employee_photo,
    required  this.employeeName
  });

  factory EmployeeData2.fromJson(Map<String, dynamic> json) {
    return EmployeeData2(
        id: json['id'] ?? '',
        employee_photo: json['employee_photo'] ?? '',
        employeeName: json['employee_name']
    );
  }

  factory EmployeeData2.empty() {
    return EmployeeData2(
        id: 0,
        employee_photo: '',
        employeeName: ''
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_photo': employee_photo,
      'employee_name': employeeName,
    };
  }
}
