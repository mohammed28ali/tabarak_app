import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabark_innov8/src/core/api/end_points.dart';

class ApiFactory {
  static final ApiFactory _instance = ApiFactory._internal();
  final Dio _dio;

  factory ApiFactory() => _instance;

  ApiFactory._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 10000),
          receiveTimeout: const Duration(seconds: 10000),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: true,
        logRequestHeaders: true,
        logResponseHeaders: true,
      ),
    );
  }

  Dio get client => _dio;

  Future<String?> _getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('APIKey');
  }

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final apiKey = await _getApiKey();
      final options = Options(
        headers: apiKey != null ? {'api-key': apiKey} : null,
      );
      return await _dio.get(endpoint,
          queryParameters: params, options: options);
    } on DioError catch (e) {
      throw Exception('GET request failed: ${e.message}');
    }
  }

  Future<Response> postRequest(
    String endpoint, {
    Map<String, dynamic>? data,
    bool sendAsFormData = false,
  }) async {
    try {
      final apiKey = await _getApiKey();
      final options = Options(
        headers: apiKey != null ? {'api-key': apiKey} : null,
      );

      if (sendAsFormData) {
        final formData = FormData.fromMap(data ?? {});
        return await _dio.post(endpoint, data: formData, options: options);
      } else {
        return await _dio.post(endpoint, data: data, options: options);
      }
    } on DioError catch (e) {
      throw Exception('POST request failed: ${e.message}');
    }
  }
}

// class ApiFactory {
//   static final ApiFactory _instance = ApiFactory._internal();
//   final Dio _dio;
//
//   factory ApiFactory() {
//     return _instance;
//   }
//
//   ApiFactory._internal()
//       : _dio = Dio(BaseOptions(
//           baseUrl: EndPoints.baseUrl,
//           connectTimeout: const Duration(milliseconds: 5000),
//           receiveTimeout: const Duration(milliseconds: 3000),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//         ));
//
//   Dio get client => _dio;
//
//   Future<Response> getRequest(String endpoint,
//       {Map<String, dynamic>? params, String? apiKey}) async {
//     try {
//       final options = Options(
//         headers: apiKey != null ? {'api-key': apiKey} : null,
//       );
//       return await _dio.get(endpoint,
//           queryParameters: params, options: options);
//     } on DioError catch (e) {
//       throw Exception('GET request failed: ${e.message}');
//     }
//   }
//
//   Future<Response> postRequest(
//     String endpoint, {
//     Map<String, dynamic>? data,
//     String? apiKey,
//     bool sendAsFormData = false,
//   }) async {
//     try {
//       _dio.interceptors.add(
//         AwesomeDioInterceptor(
//           logRequestTimeout: false,
//           logRequestHeaders: false,
//           logResponseHeaders: false,
//         ),
//       );
//       final options = Options(
//         headers: apiKey != null ? {'api-key': apiKey} : null,
//       );
//
//       if (sendAsFormData) {
//         return await _dio.post(endpoint,
//             data: FormData.fromMap(data ?? {}), options: options);
//       } else {
//         return await _dio.post(endpoint, data: data, options: options);
//       }
//     } on DioError catch (e) {
//       throw Exception('POST request failed: ${e.message}');
//     }
//   }
// }
