abstract class BaseApiService {
  Future<dynamic> get(String url, {Map<String, String> headers});

  Future<dynamic> post(String url, dynamic data, {Map<String, String> headers});

  Future<dynamic> put(String url, dynamic data);

  Future<dynamic> delete(String url, dynamic data);
}
