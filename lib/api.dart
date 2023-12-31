
class Api {



  static const baseUrl = 'http://116.203.219.132:8080/api';
  static const basePicUrl = 'http://116.203.219.132:8080';
  static const userInfoUrl = '$baseUrl/userInfo/';


  static const school_college = '$baseUrl/schoolcollege/all/';
  static const school_info = '$baseUrl/schoolcollege_otherinfo/all/';
  static const school_contact = '$baseUrl/schoolcollegecontactinfo/all/';




  static const batchUrl = '$baseUrl/batch/all/';
  static const semUrl = '$baseUrl/year/all/';

  static const allClassesUrl = '$baseUrl/classlevel/all/';
  static const ongoingClasses = '$baseUrl/class/all/';
  static const allSections = '$baseUrl/section/all/';
  static const classSection = '$baseUrl/class_section/all/';
  static const subjectUrl = '$baseUrl/subject/all/';
  static const classSubjectUrl = '$baseUrl/class_subject/all/';
  static const sectionSubjectUrl = '$baseUrl/class_subject/all/?class_section=';

  static const courseUrl = '$baseUrl/course/all/';

  static const teacherSubjectUrl = '$baseUrl/teacher_subject/all/';



  static const assignmentUrl = '$baseUrl/assignment/all/';

  static const assignmentDetailUrl = '$baseUrl/assignment/all/?class_subject=';
  static const editAssignmentUrl = '$baseUrl/assignment/';
  static const studentAssignmentUrl = '$baseUrl/student_assignment/all/';
  static const assignmentStatus = '$baseUrl/assignment_status/all/';
  static const editAssignmentStatus = '$baseUrl/assignment_status/';


  static const studentAssignmentNotification = '$baseUrl/student_assignment/';






  static const userLogin = '$baseUrl/login/';
  static const userLogout = '$baseUrl/logout/';
  static const usersAll = '$baseUrl/user/all/';

  static const notices = '$baseUrl/notice/all/';
  static const editNotices = '$baseUrl/notice/';
  static const classNotices = '$baseUrl/class_notice/all/?class_section=';
  static const editClassNotices = '$baseUrl/class_notice/';
  static const delNotices = '$baseUrl/notice/';
  static const subNotices = '$baseUrl/subjectnotice/all/';
  static const editSubNotices = '$baseUrl/subjectnotice/';

  static const eventType = '$baseUrl/eventtype/all/';
  static const subType = '$baseUrl/eventsubtype/1/';
  static const calendarEvent = '$baseUrl/calendarevents/all/';

  static const employeeInfo = '$baseUrl/employeeinfo/1/';


  static const studentInfo = "$baseUrl/studentadmission/all/";
  static const studentClassUrl = "$baseUrl/studentclass/all/";


  static const classSecSubUrl = '$baseUrl/teacher_class_subject/';
  static const teacherClass = '$baseUrl/teacher_class/all/';

  static const routineUrl = '$baseUrl/class_routine/all/';

  static const classWiseStudentUrl ='$baseUrl/class_student/all/?class_section=';

  static const subjectPlanUrl ='$baseUrl/subject_plan/all/';
  static const editSubjectPlanUrl ='$baseUrl/subject_plan/';
  static const coursePlanUrl ='$baseUrl/course_plan/all/';
  static const editCoursePlanUrl ='$baseUrl/course_plan/';



  static const teacherCourseClassUrl ='$baseUrl/teacher_course_class/';
  static const teacherCourseUrl ='$baseUrl/class_course/';



  static const teacherRoutine ='$baseUrl/teacher_class_routine/';




  static const attendanceUrl ='$baseUrl/attendance/all/';
  static const studentAttendanceUrl ='$baseUrl/student_attendance/all/';
  static const studentClassAttendanceUrl ='$baseUrl/student_attendance/all/?attendance=';
  static const editStudentAttendanceUrl ='$baseUrl/student_attendance/';
  static const studentLeaveUrl ='$baseUrl/student_leave_note/all/';
  static const studentAttendanceInfo ='$baseUrl/student_attendance/all/?student=';
  static const studentLeaveNoteUrl ='$baseUrl/student_leave_note/all/?student=';


  static const teacherAttendanceUrl ='$baseUrl/today_employee_attendance/';
  static const teacherAttendanceInfoUrl ='$baseUrl/employee_attendance_info/all/';
  static const teacherAllAttendanceInfoUrl ='$baseUrl/employee_attendance_info/all/?employee=';
  static const teacherLeaveNoteUrl ='$baseUrl/employee_leave_note/all/';



  static const examDetailUrl ='$baseUrl/exam/all/';
  static const examClassDetailUrl ='$baseUrl/exam_class/all/';
  static const examRoutineUrl ='$baseUrl/exam_routine/all/';
  static const classExamRoutineUrl ='$baseUrl/exam_routine/all/?exam=';


  static const notificationUrl = '$baseUrl/notification/all/?notification_token__notification_token=';
  static const updateNotificationUrl = '$baseUrl/notification/';






}
