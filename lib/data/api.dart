import 'package:dio/dio.dart';

class SpaceApi {
  const SpaceApi({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<Response> getPeople() {
    Future<Response> response =
        _dio.get("http://api.open-notify.org/astros.json");
    return response;
  }
}
