import 'package:dio/dio.dart';

abstract class AbstractAppRepository {
  final Dio dio;

  AbstractAppRepository({required this.dio});

  Map<String, dynamic> getHeaderWithToken(String token){
    return {
      'Authorization': 'bearer $token',
      "Content-Type": "application/json",
      "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE",
      "Accept": "application/json"
    };
  }

  Map<String, dynamic> getHeaderWithTokenForFileLoader(String token){
    return {
      'Authorization': 'bearer $token',
      //"Content-Type": "application/json",
      //"Access-Control-Allow-Methods": "GET, POST, PUT, DELETE",
      //"Accept": "application/json"
    };
  }
}