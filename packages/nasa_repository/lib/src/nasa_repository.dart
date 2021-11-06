import 'package:nasa_api/nasa_api.dart';
import 'package:nasa_repository/nasa_repository.dart';

class NasaRepository {
  NasaRepository({
    NasaApiClient? nasaApiClient,
  }) : _nasaApiClient = nasaApiClient ?? NasaApiClient();

  final NasaApiClient _nasaApiClient;

  /// Gets a [MarsPhotos]
  ///
  /// ?earth_date=[earthDate]&camera=[camera]&page=[page]
  Future<MarsPhotos> getMarsPhotosByEarthDate(
    Rovers rover, {
    required String earthDate,
    String? camera,
    int? page,
  }) {
    final params = <String, String>{
      'earth_date': earthDate,
      if (camera != null) 'camera': camera,
      if (page != null) 'page': '$page',
    };

    return _getMarsPhotos(rover, params);
  }

  /// Gets a [MarsPhotos]
  ///
  /// ?sol=[sol]&camera=[camera]&page=[page]
  Future<MarsPhotos> getMarsPhotosByMartianSol(
    Rovers rover, {
    required int sol,
    String? camera,
    int? page,
  }) {
    final params = <String, String>{
      'sol': '$sol',
      if (camera != null) 'camera': camera,
      if (page != null) 'page': '$page',
    };

    return _getMarsPhotos(rover, params);
  }

  Future<MarsPhotos> _getMarsPhotos(
    Rovers rover,
    Map<String, String> params,
  ) async {
    final response = await _nasaApiClient.getPhotos(rover, params);
    final marsPhotos = marsPhotosFromJson(response.body);

    return marsPhotos;
  }
}
