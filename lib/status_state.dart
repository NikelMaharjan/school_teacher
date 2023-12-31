
class StatusState {
  final String errorMessage;
  final bool isSuccess;
  final bool isLoad;

  StatusState(
      {required this.errorMessage,
        required this.isLoad,
        required this.isSuccess});

  StatusState copyWith({bool? isLoad, String? errorMessage, bool? isSuccess}) {
    return StatusState(
        errorMessage: errorMessage ?? this.errorMessage,
        isLoad: isLoad ?? this.isLoad,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  factory StatusState.empty() {
    return StatusState(errorMessage: '', isLoad: false, isSuccess: false);
  }
}
