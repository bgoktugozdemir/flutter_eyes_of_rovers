import 'package:enum_to_string/enum_to_string.dart';
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
    const path = 'mars-photos/api/v1/rovers/';
    const apiKey = 'DEMO_KEY';
    const rover = Rovers.curiosity;

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

    group('GET Photos', () {
      const sol = 1000;
      const mockResponseBody = '{}';
      test('makes correct http request', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await nasaApiClient.getPhotos(rover, {'sol': '$sol'});
        } catch (_) {}

        verify(() => httpClient.get(
              Uri.https(
                baseUrl,
                '$path/${EnumToString.convertToString(rover)}/photos',
                <String, dynamic>{
                  'sol': '$sol',
                  'api_key': apiKey,
                },
              ),
            )).called(1);
      });

      test('throws NasaApiRequestFailure on non-200 response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        expect(
          () async => nasaApiClient.getPhotos(rover, {'sol': '$sol'}),
          throwsA(isA<NasaApiRequestFailure>()),
        );
      });

      test('returns QueryByMartianSol on valid response', () async {
        final response = MockResponse();

        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(mockResponseBody);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        final actual = await nasaApiClient.getPhotos(rover, {'sol': '$sol'});

        expect(
          actual,
          isA<http.Response>().having(
            (response) => response.body,
            'body',
            response.body,
          ),
        );
      });
    });
  });
}
