import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget {
  static Widget buildLoadingWidget() {
    return LoadingAnimationWidget.flickr(
        size: 30, leftDotColor: Colors.red, rightDotColor: Colors.blue);
  }
}
