import 'package:flutter/material.dart';

class ImageZoom extends StatefulWidget {
  const ImageZoom({Key? key, required this.productImage})
      : assert(productImage != null),
        super(key: key);
  final String productImage;

  @override
  State<ImageZoom> createState() => _ImageZoomState();


}

class _ImageZoomState extends State<ImageZoom> {

  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void initState(){
    super.initState();
    controller = TransformationController();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: GestureDetector(
          onDoubleTapDown: (details) => tapDownDetails = details,
          onDoubleTap: (){
            final double scale = 3;
            final position = tapDownDetails!.localPosition;

            final x = -position.dx * (scale - 1);
            final y = -position.dy * (scale - 1);
            final zoomed = Matrix4.identity()
              ..translate(x,y)
              ..scale(scale);
            final value =
            controller.value.isIdentity()? zoomed: Matrix4.identity()    ;
            controller.value = value;
          },
          child: InteractiveViewer(
            transformationController: controller,
            clipBehavior: Clip.none,
            panEnabled: false,
            child: AspectRatio(
              aspectRatio:0.5,
              child:
              Image.network(widget.productImage),
            ),
          ),
        ),
      ),


    );
  }
}
