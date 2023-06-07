import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/photo_provider.dart';
import '../photo_details/photo_details_view.dart';
import '../widgets/loading_widget.dart';

class PhotoGridView extends StatefulWidget {
  const PhotoGridView({super.key});

  @override
  PhotoGridViewState createState() => PhotoGridViewState();
}

class PhotoGridViewState extends State<PhotoGridView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<PhotoProvider>(context, listen: false);
    if (!_scrollController.position.outOfRange &&
        _scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
      provider.fetchPhotos();
    }
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }

    return input[0].toUpperCase() + input.substring(1);
  }

  Widget _buildGridView() {
    final photoProvider = Provider.of<PhotoProvider>(context);

    if (photoProvider.isLoading && photoProvider.photos.isEmpty) {
      return Center(child: LoadingWidget.buildLoadingWidget());
    } else if (photoProvider.hasError && photoProvider.photos.isEmpty) {
      return Center(child: Text(photoProvider.errorMessage));
    } else {
      return GridView.builder(
        controller: _scrollController,
        itemCount: photoProvider.photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          final photo = photoProvider.photos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailsScreen(photo: photo),
                ),
              );
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  capitalizeFirstLetter(
                    photo.title.trim(),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: photo.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: LoadingWidget.buildLoadingWidget()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EarniPay Photo Viewer',
        ),
      ),
      body: _buildGridView(),
    );
  }
}
