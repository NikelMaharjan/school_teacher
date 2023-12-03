




import 'package:eschool_teacher/features/model/crud_state.dart';
import 'package:eschool_teacher/features/services/notice_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final subNoticeProvider = StateNotifierProvider<NoticeNotifier, CrudState>((ref) => NoticeNotifier(CrudState.empty()));
final noticeProvider = StateNotifierProvider<NoticeNotifier, CrudState>((ref) => NoticeNotifier(CrudState.empty()));
final classNoticeProvider = StateNotifierProvider<NoticeNotifier, CrudState>((ref) => NoticeNotifier(CrudState.empty()));



class NoticeNotifier extends StateNotifier<CrudState>{
  NoticeNotifier(super.state);

  Future<void> addNotice({
    required String token,
    required String title,
    required String description,
    required bool for_all_class,
    required bool notification,
    String? image,
    required int added_by,
    required int notice_type,

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await NoticeService(token).addNotice(
        title: title,
        description: description,
        for_all_class: for_all_class,
        notification: notification,
        added_by: added_by,

        notice_type: notice_type,
        image: image ?? null
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> updateNotice({
    required String token,
    required String title,
    required String description,
    required bool for_all_class,
    required bool notification,
    String? image,
    required int added_by,
    required int notice_type,
    required int id

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await NoticeService(token).updateNotice(
        title: title,
        description: description,
        for_all_class: for_all_class,
        notification: notification,
        added_by: added_by,
        id: id,
        notice_type: notice_type);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


  Future<void> addClassNotice({
    required String token,
    required int notice,
    required int classSection,
  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await ClassNoticeService(token).addClassNotice(
        classSection: classSection,
        notice: notice
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> delClassNotice(
      int id, String token,
      ) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await ClassNoticeService(token).delClassNotice(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);
    });
  }

  
  Future<void> addSubNotice({
    required String token,
    required String title,
    required String message,
    required int class_subject,

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await SubjectNoticeService(token).addSubNotice(
        title: title,
        message: message,

        class_subject: class_subject
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> deleteData(
      int id, String token,
      ) async{

    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await SubjectNoticeService(token).delSubNotice(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });


  }

  Future<void> updateSubNotice({
    required int id,
    required String title,
    required String message,
    required String token,
    required int class_subject

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await SubjectNoticeService(token).updateSubNotice(title: title, message: message, id: id,class_subject: class_subject);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }

  
}