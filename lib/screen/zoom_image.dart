import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ZoomImage extends StatefulWidget {
  const ZoomImage({Key? key}) : super(key: key);

  @override
  _ZoomImageState createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider:
          NetworkImage("https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg"),
        ),
      ),
    );
  }
}
