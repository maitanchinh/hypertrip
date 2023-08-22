import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/attachment/upload_attachment_response.dart';
import 'package:hypertrip/utils/get_it.dart';

class AttachmentRepo {
  final Dio apiClient = getIt.get<Dio>();

  AttachmentRepo();

  Future<UploadAttachmentResponse?> postAttachment(String path) async {
    try {
      var attachment = await MultipartFile.fromFile(path);
      var formData = FormData.fromMap({'file': attachment});

      var res = await apiClient.post('/attachments', data: formData);

      return res.data != null
          ? UploadAttachmentResponse.fromJson(res.data)
          : null;
    } catch (e) {
      return null;
    }
  }
}
