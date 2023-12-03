//a profile for a schoolcollege using the system, every data of a schoolcollege revolves around this model.
class School {
  final int id;
  final String name;
  final String shortName;
  final String logo;
  final String schoolType;
  final String? coverPhoto;
  final DateTime establishedDate;
  final String principalName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  School({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logo,
    required this.schoolType,
    required this.coverPhoto,
    required this.establishedDate,
    required this.principalName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      logo: json['logo'],
      schoolType: json['school_type'],
      coverPhoto: json['cover_photo']??null,
      establishedDate: DateTime.parse(json['established_date']),
      principalName: json['principal_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'logo': logo,
      'school_type': schoolType,
      'cover_photo': coverPhoto,
      'established_date': establishedDate.toIso8601String(),
      'principal_name': principalName,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}


class SchoolOtherInfo {
  int id;
  String schoolHours;
  String schoolMotto;
  String achievements;
  String communityInvolvementInfo;
  String resourceInfo;
  String createdAt;
  String updatedAt;
  int schoolCollege;

  SchoolOtherInfo({
    required this.id,
    required this.schoolHours,
    required this.schoolMotto,
    required this.achievements,
    required this.communityInvolvementInfo,
    required this.resourceInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory SchoolOtherInfo.fromJson(Map<String, dynamic> json) => SchoolOtherInfo(
    id: json['id'],
    schoolHours: json['school_hours'],
    schoolMotto: json['school_motto'],
    achievements: json['achievements'],
    communityInvolvementInfo: json['community_involvement_info'],
    resourceInfo: json['resource_info'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    schoolCollege: json['school_college'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'school_hours': schoolHours,
    'school_motto': schoolMotto,
    'achievements': achievements,
    'community_involvement_info': communityInvolvementInfo,
    'resource_info': resourceInfo,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'school_college': schoolCollege,
  };
}


class SchoolContact {
  int id;
  String email;
  String address;
  String phoneNumber;
  String? website;
  String createdAt;
  String updatedAt;
  int schoolCollege;

  SchoolContact({
    required this.id,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory SchoolContact.fromJson(Map<String, dynamic> json) {
    return SchoolContact(
      id: json['id'],
      email: json['email']??'',
      address: json['address']??'',
      phoneNumber: json['phone_number']??'',
      website: json['website']??'',
      createdAt: json['created_at']??'',
      updatedAt: json['updated_at']??'',
      schoolCollege: json['school_college']??'',
    );
  }
}



class Courses {
  int id;
  String courseName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int schoolCollege;

  Courses({
    required this.id,
    required this.courseName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.schoolCollege,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'],
      courseName: json['course_name'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      schoolCollege: json['school_college'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt.toIso8601String();
    data['updated_at'] = this.updatedAt.toIso8601String();
    data['school_college'] = this.schoolCollege;
    return data;
  }
}
