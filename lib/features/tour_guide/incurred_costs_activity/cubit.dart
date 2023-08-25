import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/incurred_cost_activity.dart';
import 'package:hypertrip/domain/models/attachment/upload_attachment_response.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/domain/repositories/attachment_repo.dart';
import 'package:hypertrip/exceptions/request_exception.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/widgets/popup/p_error_popup.dart';

class IncurredCostsActivityCubit extends Cubit<IncurredCostsActivityState> {
  final ActivityRepo _activityRepo = getIt.get<ActivityRepo>();
  final AttachmentRepo _attachmentRepo = getIt.get<AttachmentRepo>();
  final BuildContext _context;

  IncurredCostsActivityCubit(this._context)
      : super(IncurredCostsActivityState.initial());

  Future<bool> create() async {
    try {
      final rootState = _context.read<RootCubit>().state as RootSuccessState;
      final activityState = _context.read<ActivityCubit>().state;

      await _activityRepo.createNewIncurredCostsActivity(
        tourGroupId: rootState.group!.id!,
        imagePath: state.imagePaths.isNotEmpty ? state.imagePaths[0] : null,
        amount: state.amount,
        dayNo: activityState.selectedDay + 1,
        note: state.note,
        dateTime: state.dateTime,
      );

      return true;
    } on RequestException catch (e) {
      debugPrint(e.toString());
      showErrorPopup(_context, content: e.message);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  Future<bool> update() async {
    try {
      /// Upload image variable
      UploadAttachmentResponse? uploadedImage;

      /// Check image changed
      if (state.preImagePath != null &&
          state.preImagePath != state.imagePaths[0]) {
        /// Begin upload image
        var imagePath =
            state.imagePaths.isNotEmpty ? state.imagePaths[0] : null;
        if (imagePath != null && imagePath.isNotEmpty) {
          uploadedImage = await _attachmentRepo.postAttachment(imagePath);

          if (uploadedImage == null) {
            throw RequestException(msg_upload_image_failed);
          }
        }
      }

      await _activityRepo.patchUpdate({
        "type": ActivityType.IncurredCost.name,
        "incurredCostActivity": {
          "id": state.id,
          "cost": state.amount,
          "createdAt": state.dateTime.toIso8601String(),
          "note": state.note,
          "imageId": uploadedImage?.id,
          'currency': 'đ',
        }
      });

      return true;
    } on RequestException catch (e) {
      debugPrint(e.toString());
      showErrorPopup(_context, content: e.message);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    /// Fallback result
    return false;
  }

  Future<void> load(String id) async {
    emit(
        IncurredCostsActivityState.initial().copyWith(isLoading: true, id: id));
    try {
      var res = await _activityRepo.get(id);
      var activity = IncurredCostActivityModel.fromJson(res.data);

      onStateChanged(state.copyWith(
        amount: activity.cost,
        note: activity.note,
        dateTime: activity.createdAt,
        imagePaths: activity.imageUrl != null ? [activity.imageUrl!] : [],
        isLoading: false,
        isAmountValid: true,
        isNoteValid: true,
        preImagePath: activity.imageUrl,
      ));
    } on Exception catch (e) {
      emit(IncurredCostsActivityState.initial().copyWith(isLoading: false));
      if (e is RequestException) {
        debugPrint(e.toString());
        showErrorPopup(_context, content: e.message);
      } else {
        debugPrint(e.toString());
      }
    }
  }

  void init() {
    emit(IncurredCostsActivityState.initial());
  }

  void onStateChanged(IncurredCostsActivityState newState) {
    emit(newState);
  }

  void setDate(DateTime value) {
    var newDate = state.dateTime
        .copyWith(year: value.year, month: value.month, day: value.day);

    onStateChanged(state.copyWith(dateTime: newDate));
  }

  void setTime(DateTime value) {
    var newTime = state.dateTime
        .copyWith(hour: value.hour, minute: value.minute, second: value.second);

    onStateChanged(state.copyWith(dateTime: newTime));
  }

  void setImagePaths(List<String> imagePaths) {
    var newState = state.copyWith(imagePaths: imagePaths);

    onStateChanged(newState);
  }

  Future<void> removeDraft(String id) async {
    await _activityRepo.removeDraft(id);
  }
}
