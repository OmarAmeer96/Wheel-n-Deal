import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = '';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.post('$_baseUrl$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.put('$_baseUrl$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    var response = await _dio.delete('$_baseUrl$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> patch({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.patch('$_baseUrl$endPoint', data: data);
    return response.data;
  }
}
