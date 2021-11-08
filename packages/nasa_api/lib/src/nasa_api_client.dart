import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_api/nasa_api.dart';

class NasaApiClient {
  NasaApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.nasa.gov';
  static const _path = 'mars-photos/api/v1/rovers/';
  static const _apiKey = 'DEMO_KEY';

  final http.Client _httpClient;

  /// Gets *photos* from **NASA Rovers API**
  Future<http.Response> getPhotos(Rovers rover, Map<String, String> params) =>
      _get('${EnumToString.convertToString(rover)}/photos', params);

  Future<http.Response> _get(String subPath, Map<String, String> params) async {
    params['api_key'] = _apiKey;
    final request = Uri.https(
      _baseUrl,
      '$_path/$subPath',
      params,
    );

    final response = await _httpClient.get(request);

    if (response.statusCode == 429) {
      throw NasaApiOverRateLimitFailure();
    } else if (response.statusCode != HttpStatus.ok) {
      throw NasaApiRequestFailure();
    } else {
      return response;
    }
  }
}
