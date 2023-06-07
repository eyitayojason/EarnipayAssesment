import 'package:flutter/foundation.dart';

import '../models/fetch_photo_model.dart';
import '../networking/api_service.dart';

class PhotoProvider with ChangeNotifier {
  final ApiService apiService;
  final List<Photo> _photos = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  PhotoProvider(this.apiService) {
    fetchPhotos();
  }

  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> fetchPhotos() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final List<Photo> fetchedPhotos =
          await apiService.fetchPhotos(page: _page);
      _photos.addAll(fetchedPhotos);
      _page++;
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Failed to fetch photos';
    }

    _isLoading = false;
    notifyListeners();
  }
}
