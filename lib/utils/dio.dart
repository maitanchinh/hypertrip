import 'package:dio/dio.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

final apiClient = Dio()
  ..options.baseUrl = AppConstant.API_URL
  ..options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  }
  ..interceptors.addAll([
    LogInterceptor(
      responseBody: true,
      // requestBody: true,
    ),
    InterceptorsWrapper(
      // onError: (error, handler) {
      //   print(error);
      //   return handler.next(error);
      // },
      onRequest: (request, handler) async {
        var token = getStringAsync(AppConstant.TOKEN_KEY);
        if (token.isNotEmpty) {
          request.headers['Authorization'] = token;
        }

        return handler.next(request);
      },
      // onResponse: (response, handler) {
      //   print(response);
      //   return handler.next(response);
      // },
    ),
  ]);

final fourSquareApiClient = Dio()
  ..options.baseUrl = AppConstant.PUBLIC_API_URL
  ..options.headers = {
    'Accept': 'application/json',
    // 'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
    'Authorization': AppConstant.FOUR_SQUARE_TOKEN,
    'Host': 'api.foursquare.com'
  }
  ..interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (request, handler) async {
        return handler.next(request);
      },
    )
  ]);
