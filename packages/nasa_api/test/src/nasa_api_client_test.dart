import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_api/nasa_api.dart';
import 'package:nasa_api/src/nasa_api_client.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('NasaApiClient', () {
    late http.Client httpClient;
    late NasaApiClient nasaApiClient;

    const baseUrl = 'api.nasa.gov';
    const path = 'mars-photos/api/v1/rovers/curiosity/photos';
    const apiKey = 'DEMO_KEY';

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      nasaApiClient = NasaApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(NasaApiClient(), isNotNull);
      });
    });

    group('GET Query By Martian Sol', () {
      const sol = 1000;
      const mockResponseBody = '''{ 
            "photos": [ { 
              "id": 424926, 
              "sol": 1000, 
              "camera": { 
                "id": 22, 
                "name": "MAST", 
                "rover_id": 5, 
                "full_name": "Mast Camera" 
              }, 
              "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631200305217E01_DXXX.jpg", 
              "earth_date": "2015-05-30", 
              "rover": { 
                "id": 5, 
                "name": "Curiosity", 
                "landing_date": "2012-08-06", 
                "launch_date": "2011-11-26", 
                "status": "active"
              } } ] }''';
      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await nasaApiClient.getQueryByMartianSol(sol: sol);
        } catch (_) {}

        verify(() => httpClient.get(
              Uri.https(
                baseUrl,
                path,
                <String, dynamic>{
                  'sol': '$sol',
                  'api_key': apiKey,
                },
              ),
            )).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () async => nasaApiClient.getQueryByMartianSol(sol: sol),
          throwsA(isA<Exception>()),
        );
      });

      test('returns QueryByMartianSol on valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await nasaApiClient.getQueryByMartianSol(sol: sol);

        expect(
          actual,
          isA<QueryByMartianSol>().having(
            (response) => response.photos,
            'photos',
            isA<List<Photo>>().having(
              (photos) => photos.first,
              'photo',
              isA<Photo>()
                  .having(
                    (photo) => photo.id,
                    'id',
                    424926,
                  )
                  .having(
                    (photo) => photo.sol,
                    'sol',
                    sol,
                  )
                  .having(
                    (photo) => photo.imgSrc,
                    'img_src',
                    'http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631200305217E01_DXXX.jpg',
                  )
                  .having(
                    (photo) => photo.earthDate,
                    'earth_date',
                    DateTime.parse('2015-05-30'),
                  )
                  .having(
                    (photo) => photo.camera,
                    'camera',
                    isA<Camera>()
                        .having(
                          (camera) => camera.id,
                          'id',
                          22,
                        )
                        .having(
                          (camera) => camera.name,
                          'name',
                          'MAST',
                        )
                        .having(
                          (camera) => camera.roverId,
                          'rover_id',
                          5,
                        )
                        .having(
                          (camera) => camera.fullName,
                          'full_name',
                          'Mast Camera',
                        ),
                  )
                  .having(
                    (photo) => photo.rover,
                    'rover',
                    isA<Rover>()
                        .having(
                          (rover) => rover.id,
                          'id',
                          5,
                        )
                        .having(
                          (rover) => rover.name,
                          'name',
                          'Curiosity',
                        )
                        .having(
                          (rover) => rover.status,
                          'status',
                          'active',
                        )
                        .having(
                          (rover) => rover.landingDate,
                          'landing_date',
                          DateTime.parse('2012-08-06'),
                        )
                        .having(
                          (rover) => rover.launchDate,
                          'launch_date',
                          DateTime.parse('2011-11-26'),
                        ),
                  ),
            ),
          ),
        );
      });
    });

    group('GET Query By Earth Date', () {
      const earthDate = '2015-06-03';
      const mockResponseBody = '''{ 
            "photos":[ { 
              "id":102685, 
              "sol":1004, 
              "camera":{ 
                "id":20, 
                "name":"FHAZ", 
                "rover_id":5, 
                "full_name":"Front Hazard Avoidance Camera" 
                }, 
                "img_src":"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG", 
                "earth_date":"2015-06-03", 
                "rover":{ 
                  "id":5, 
                  "name":"Curiosity", 
                  "landing_date":"2012-08-06", 
                  "launch_date":"2011-11-26", 
                  "status":"active" 
                  } } ] }''';

      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get((any()))).thenAnswer((_) async => response);

        try {
          await nasaApiClient.getQueryByEarthDate(earthDate: earthDate);
        } catch (e) {}

        verify(() => httpClient.get(
              Uri.https(
                baseUrl,
                path,
                <String, dynamic>{
                  'earth_date': earthDate,
                  'api_key': apiKey,
                },
              ),
            )).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () async => nasaApiClient.getQueryByEarthDate(earthDate: earthDate),
          throwsA(isA<Exception>()),
        );
      });

      test('returns QueryByEarthDate on valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual =
            await nasaApiClient.getQueryByEarthDate(earthDate: earthDate);

        expect(
          actual,
          isA<QueryByEarthDate>().having(
            (response) => response.photos,
            'photos',
            isA<List<Photo>>().having(
                (photos) => photos.first,
                'photo',
                isA<Photo>()
                    .having(
                      (photo) => photo.id,
                      'id',
                      102685,
                    )
                    .having(
                      (photo) => photo.sol,
                      'sol',
                      1004,
                    )
                    .having(
                      (photo) => photo.earthDate,
                      'earth_date',
                      DateTime.parse(earthDate),
                    )
                    .having(
                      (photo) => photo.imgSrc,
                      'img_src',
                      'http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG',
                    )
                    .having(
                      (photo) => photo.camera,
                      'camera',
                      isA<Camera>()
                          .having(
                            (camera) => camera.id,
                            'id',
                            20,
                          )
                          .having(
                            (camera) => camera.name,
                            'name',
                            'FHAZ',
                          )
                          .having(
                            (camera) => camera.roverId,
                            'rover_id',
                            5,
                          )
                          .having(
                            (camera) => camera.fullName,
                            'full_name',
                            'Front Hazard Avoidance Camera',
                          ),
                    )
                    .having(
                      (photo) => photo.rover,
                      'rover',
                      isA<Rover>()
                          .having(
                            (rover) => rover.id,
                            'id',
                            5,
                          )
                          .having(
                            (rover) => rover.status,
                            'status',
                            'active',
                          )
                          .having(
                            (rover) => rover.name,
                            'name',
                            'Curiosity',
                          )
                          .having(
                            (rover) => rover.landingDate,
                            'landing_date',
                            DateTime.parse('2012-08-06'),
                          )
                          .having(
                            (rover) => rover.launchDate,
                            'launch_date',
                            DateTime.parse('2011-11-26'),
                          ),
                    )),
          ),
        );
      });
    });
  });
}
