import 'dart:convert';

import 'package:extension_tech_task_app/data/network_service/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {

  // dependency injection
  final http.Client client;

  NetworkApiService(this.client);

  @override
  Future get(String url, {Map<String, String> headers = const {}}) async {
    dynamic responseJson = {"status": false};

    try {
      final response =
          await client.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 10));
      responseJson = resolveResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future post(String url, dynamic data, {Map<String, String> headers = const {}}) async {
    dynamic responseJson = {"status": false};

    final requestHeaders = Map<String, String>.from(headers)..addAll({'Content-type': 'application/json'});

    try {
      final response = await client.post(Uri.parse(url),
          headers: requestHeaders,
          body: json.encode(data));

      responseJson = resolveResponse(response);
    } catch (e) {
      rethrow;
    }

    return responseJson;
  }

  @override
  Future delete(String url, dynamic data) async {
    dynamic responseJson = {"status": false};

    try {
      final response = await client.delete(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: json.encode(data));

      responseJson = resolveResponse(response);
    } catch (e) {
      rethrow;
    }

    return responseJson;
  }

  @override
  Future<dynamic> put(String url, dynamic data) async {
    dynamic responseJson = {"status": false};

    try {
      final response = await client.put(Uri.parse(url),
          headers: {'Content-type': 'application/json'},
          body: json.encode(data));

      responseJson = resolveResponse(response);
    } catch (e) {
      rethrow;
    }

    return responseJson;
  }

  dynamic resolveResponse(http.Response response) {
    return json.decode(response.body);
  }
}
