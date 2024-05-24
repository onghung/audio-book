import 'package:dio/dio.dart';
import 'package:tlubook/services/sever_setting.dart';
import 'dart:async';
import '../models/model_book.dart';


class TabRepository {
  final _api = "${ServerSetting.getBaseUrl()}/api";
  Dio dio = Dio();

  Future<List<Book>> fetchBooks() async {
    try {
      Response response = await dio.get('$_api/book');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Book.fromJson(json)).toList();
      } else {
        // Nếu mã trạng thái không phải là 200, xử lý lỗi
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
      return [];
    }
  }


  Future<Map<String, dynamic>> login( email,  password) async {
    try {
      final response = await dio.post(
        '$_api/signin',
        data: {
          "email": "$email",
          "password": "$password",
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Ensure response.data is a Map<String, dynamic>
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else {
          throw Exception('Response data format is invalid');
        }
      } else {
        throw Exception('Failed to login');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response?.data}');
        if (e.response?.data is Map<String, dynamic>) {
          throw Exception('Failed to login: ${e.response?.data['error']}');
        } else {
          throw Exception('Failed to login: Unexpected response format');
        }
      } else {
        throw Exception('Failed to login: ${e.message}');
      }
    }
  }
}

