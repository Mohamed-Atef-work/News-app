import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      receiveDataWhenStatusError: true,
    ),
  );

  // base url for eCommerce app "postman"
  // https://student.valuxapps.com/api/

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    //String lang = "en",
    //String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
