import 'package:flutter/material.dart';
import '../../models/fetch_photo_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/loading_widget.dart';
import 'photo_details_viewmodel.dart';

class PhotoDetailsScreen extends StatefulWidget {
  final Photo photo;

  const PhotoDetailsScreen({Key? key, required this.photo}) : super(key: key);

  @override
  PhotoDetailsScreenState createState() => PhotoDetailsScreenState();
}

class PhotoDetailsScreenState extends State<PhotoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoDetailsViewModel>(
      create: (_) => PhotoDetailsViewModel(),
      child: Consumer<PhotoDetailsViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.photo.title,
                ),
              ),
              body: Center(child: LoadingWidget.buildLoadingWidget()),
            );
          } else if (viewModel.hasError) {
            return Scaffold(
              appBar: AppBar(title: Text(widget.photo.title)),
              body: Center(child: Text(viewModel.errorMessage)),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  viewModel.capitalizeFirstLetter(widget.photo.title.trim()),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.photo.imageUrl,
                        placeholder: (context, url) =>
                            LoadingWidget.buildLoadingWidget(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Description: ${widget.photo.description}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      Text('Author: ${widget.photo.author}'),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
