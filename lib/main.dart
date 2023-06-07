import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'networking/api_service.dart';
import 'provider/photo_provider.dart';
import 'ui/photo_grid/photo_grid_view.dart';

void main() {
  runApp(
    const EarniPayPhotoViewer(),
  );
}

class EarniPayPhotoViewer extends StatelessWidget {
  const EarniPayPhotoViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhotoProvider(
        ApiService(),
      ),
      child: MaterialApp(
        title: 'EarniPay Photo Viewer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'Poppins',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const DefaultTextStyle(
          style: TextStyle(fontFamily: 'Poppins'),
          child: PhotoGridView(),
        ),
      ),
    );
  }
}
