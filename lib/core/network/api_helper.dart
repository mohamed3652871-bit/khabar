import 'package:dio/dio.dart';
import '../cache/cache_keys.dart';
import '../cache/cache_helper.dart';
import 'api_response.dart';
import 'end_points.dart';


class APIHelper {


  // declaring dio
  static final Dio _dio = Dio(
      BaseOptions(baseUrl: EndPoints.baseURL)
  );

  static Future init() async {
    _dio.interceptors.add(
      InterceptorsWrapper(
      // Request interceptor
      onRequest: (options, handler) {
         // print("--- Headers : ${options.headers.toString()}");
         // print("--- endpoint : ${options.path.toString()}");
         return handler.next(options);
      },

        // Response interceptor
       onResponse: (response, handler) {
         // print("--- Response : ${response.data.toString()}");
         return handler.next(response);
       },

        // Error interceptor
        onError: (DioException error, handler) async {
        // print("--- Error : ${error.response?.data.toString()}");

          var errorResponse = error.response?.data as Map<String, dynamic>;
            try {
               if (errorResponse['message'].toString().contains('Token has expired.'))
               {
                 var result = await _dio.post(
                   EndPoints.apiToken,
                   options: Options(headers: {'Authorization': 'Bearer ${await CacheHelper.getValue(CacheKeys.refreshToken)}'})
                 ) ;

                 Map<String, dynamic> accessData = result.data as Map<String, dynamic>;
                    await CacheHelper.setValue(CacheKeys.accessToken, accessData['access_token']);

                   // Retry original request
                  final options = error.requestOptions;
                    if (options.data is FormData) {
                      // Convert FormData to map so it can be rebuilt
                      final oldFormData = options.data as FormData;
                      final Map<String, dynamic> formMap = {};

                      for (var entry in oldFormData.fields) {
                        formMap[entry.key] = entry.value;
                      }

                      // Add files if any
                      for (var file in oldFormData.files) {
                        formMap[file.key] = file.value;
                      }

                      // Rebuild new FormData
                      options.data = FormData.fromMap(formMap);
                    }

                  options.headers['Authorization'] =
                  'Bearer ${CacheHelper.getValue(CacheKeys.accessToken) ?? ''}';
                  final response = await _dio.fetch(options);
                  return handler.resolve(response);
               }
            }
            catch (e) {
              return handler.next(error);
            }
            return handler.next(error);
        }
      )
    );
  }




  // getRequest

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async
  {
    try {
      var response = await _dio.get(endPoint, queryParameters: queryParams);
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  // postRequest

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async
  {
    try {
      var response = await _dio.post(
        endPoint,
        data: data == null
            ? null
            : isFormData
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // ignore: avoid_print
      return ApiResponse.fromError(e);
    }
  }
  // putRequest

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async
  {
    try {
      var response = await _dio.put(
        endPoint,
        data: data == null
            ? null
            : isFormData
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
  // deleteRequest

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async
  {
    try {
      var response = await _dio.delete(
        endPoint,
        data: data == null
            ? null
            : isFormData
            ? FormData.fromMap(data)
            : data,
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}




















