import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nasa_api/nasa_api.dart';

class NasaApiClient {
  NasaApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.nasa.gov';
  static const _path = 'mars-photos/api/v1/rovers/curiosity/photos';
  static const _apiKey = 'DEMO_KEY';

  final http.Client _httpClient;

  /// Finds a [QueryByEarthDate]
  ///
  /// ?earth_date=[earthDate]&camera=[camera]&page=[page]
  Future<QueryByEarthDate> getQueryByEarthDate({
    required String earthDate,
    String? camera,
    int? page,
  }) async {
    final response = await _get({
      'earth_date': earthDate,
      if (camera != null) 'camera': camera,
      if (page != null) 'page': '$page',
    });

    final queryByEarthDate = queryByEarthDateFromJson(response.body);

    return queryByEarthDate;
  }

  /// Finds a [QueryByMartianSol]
  ///
  /// ?sol=[sol]&camera=[camera]&page=[page]
  Future<QueryByMartianSol> getQueryByMartianSol({
    required int sol,
    String? camera,
    int? page,
  }) async {
    final params = <String, String>{
      'sol': '$sol',
      if (camera != null) 'camera': camera,
      if (page != null) 'page': '$page',
    };
    final response = await _get(params);

    final queryByMartianSol = queryByMartianSolFromJson(response.body);

    return queryByMartianSol;
  }

  Future<http.Response> _get(Map<String, String> params) async {
    params['api_key'] = _apiKey;
    final request = Uri.https(
      _baseUrl,
      _path,
      params,
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception(); // TODO: QueryByEarthDateRequestFailure
    } else {
      return response;
    }
  }
}
