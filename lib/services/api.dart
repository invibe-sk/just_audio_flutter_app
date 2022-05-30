import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:knihy_audio_app_new/services/device_info.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';

class Api {
  final String _baseUri = "https://knihy.audio.invibe.site/api";
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  static const String tokenKeyName = 'knihyaudio-personal-access-token';
  final DeviceInfo deviceInfo = getIt<DeviceInfo>();

  Future<Map<String, String>> _getHeaders({bool withAuth = true}) async {
    Map<String, String> headers = {'X-Requested-With': 'XMLHttpRequest'};

    String? token = await getToken();

    if (token != null && withAuth) {
      headers['Authorization'] = "Bearer $token";
    }

    return headers;
  }

  Future<String?> getToken() {
    return storage.read(key: tokenKeyName);
  }

  Future<void> setToken(String token) {
    return storage.write(key: tokenKeyName, value: token);
  }

  Future<void> removeToken() {
    return storage.delete(key: tokenKeyName);
  }

  Uri _getUri(String path) {
    return Uri.parse("$_baseUri$path");
  }

  Future<http.Response> loginRequest({String? email, String? password}) async {
    http.Response res = await http.post(
      _getUri("/login"),
      body: {
        'email': email ?? '',
        'password': password ?? '',
        'device_name': deviceInfo.deviceName()
      },
      headers: await _getHeaders(withAuth: false),
    );

    if (res.statusCode == 200) {
      setToken(jsonDecode(res.body)['token']);
    }

    return res;
  }

  Future<http.Response> logoutRequest() async {
    http.Response res = await http.post(_getUri("/logout"), headers: await _getHeaders());

    if (res.statusCode == 200) {
      await removeToken();
    }

    return res;
  }

  Future<http.Response> myBooksRequest() async {
    return http.get(_getUri("/books"), headers: await _getHeaders());
  }

  Future<http.Response> otherBooksRequest() async {
    return http.get(_getUri("/books/other"), headers: await _getHeaders());
  }

  Future<http.Response> bookRequest({required String id}) async {
    return http.get(_getUri("/books/$id"), headers: await _getHeaders());
  }
}
