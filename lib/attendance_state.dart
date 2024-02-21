
class AttendanceState {
  final String errorMessage;
  final bool isSuccess;
  final bool isLoad;
  bool? isAttendanceSuccess;
  bool? isLeaveSuccess;
  String? attendanceErrorMessage;

  AttendanceState(
      {required this.errorMessage,
        required this.isLoad,
        this.isLeaveSuccess,
        this.isAttendanceSuccess,
        this.attendanceErrorMessage,
        required this.isSuccess});

  AttendanceState copyWith({bool? isLoad, String? attendanceErrorMessage, String? errorMessage, bool? isSuccess, bool? isAttendanceSuccess, bool? isLeaveSuccess}) {
    return AttendanceState(
        errorMessage: errorMessage ?? this.errorMessage,
        isLoad: isLoad ?? this.isLoad,
        attendanceErrorMessage: attendanceErrorMessage ?? this.attendanceErrorMessage,
        isLeaveSuccess: isLeaveSuccess ?? this.isLeaveSuccess,
        isAttendanceSuccess: isAttendanceSuccess ?? this.isAttendanceSuccess,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  factory AttendanceState.empty() {
    return AttendanceState(errorMessage: '', isLoad: false, attendanceErrorMessage: "", isSuccess: false,  );
  }
}
