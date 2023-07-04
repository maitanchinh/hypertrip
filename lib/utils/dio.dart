import 'package:dio/dio.dart';
import 'package:hypertrip/utils/constant.dart';

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
        // var token = getStringAsync(AppConstant.tokenKey);
        var token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIxNzUxYTljLWZjZDktNGZjYy05M2VkLTdhNDM0OWEzNGJjNyIsInJvbGUiOiJUb3VyR3VpZGUiLCJuYmYiOjE2ODY1MTE5MDAsImV4cCI6MTcxODA0NzkwMCwiaWF0IjoxNjg2NTExOTAwLCJpc3MiOiJUcmF2ZWxlckJFIiwiYXVkIjoiVHJhdmVsZXJCRSJ9.4HRZrtuelOJoziocu6MpDHYpobMXuFSZWYK0LF5W0DU";
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

final publishApiClient = Dio()
  ..options.baseUrl = AppConstant.PUBLIC_API_URL
  ..options.headers = {
    'Accept': 'application/json',
    // 'Authorization': 'fsq37qFTKrGLWiBZDd6Eexr+8xiKOhen6VB/vTmq42RlKSs=',
    'Authorization': 'fsq3qh6o+HDC6TCgGVeWucT3bZp1579crXXfJLM77vyTKQQ=',
    'Host': 'api.foursquare.com'
  }
  ..interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (request, handler) async {
        return handler.next(request);
      },
    )
  ]);
