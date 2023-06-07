import 'package:earnipay_assesment/models/fetch_photo_model.dart';
import 'package:earnipay_assesment/networking/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiService', () {
    test('fetchPhotos should return a list of photos', () async {
      final apiService = ApiService();
      final response = await apiService.fetchPhotos();

      expect(response, isList);
      expect(response.length, greaterThan(0));
      expect(response.first, isA<Photo>());
    });

    test(
      'fetchPhotos should throw an exception if the response status code is not 200',
      () async {
        final apiService = ApiService();

        try {
          await apiService.fetchPhotos(page: 1, perPage: 100);
          fail('Exception expected');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      },
    );
  });
}
