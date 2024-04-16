import 'package:dio/dio.dart';
import 'package:tlubook/services/sever_setting.dart';
import 'dart:async';
import '../models/model_book.dart';


class TabRepository {
  static final _api = "${ServerSetting.getBaseUrl()}/api";
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
}

