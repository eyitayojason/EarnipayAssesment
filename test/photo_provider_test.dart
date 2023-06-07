import 'package:earnipay_assesment/models/fetch_photo_model.dart';
import 'package:earnipay_assesment/networking/api_service.dart';
import 'package:earnipay_assesment/provider/photo_provider.dart';
import 'package:flutter_test/flutter_test.dart';

class TestApiService implements ApiService {
  @override
  Future<List<Photo>> fetchPhotos({int page = 1, int perPage = 20}) async {
    final result = [
      Photo(
        id: '1',
        title: 'Photo 1',
        imageUrl: 'https://example.com/photo1.jpg',
        description: '',
        author: 'Author 1',
      ),
      Photo(
        id: '2',
        title: 'Photo 2',
        imageUrl: 'https://example.com/photo2.jpg',
        description: '',
        author: 'Author 2',
      ),
    ];
    return result;
  }
}

void main() {
  group('PhotoProvider', () {
    test('fetchPhotos adds fetched photos to the list', () async {
      final apiService = TestApiService();
      final photoProvider = PhotoProvider(apiService);

      await photoProvider.fetchPhotos();

      expect(photoProvider.photos.length, 2);
      expect(photoProvider.photos[0].title, 'Photo 1');
      expect(photoProvider.photos[1].title, 'Photo 2');
    });
  });
}
