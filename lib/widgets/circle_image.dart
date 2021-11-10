import 'package:flutter/widgets.dart';

class CircleImage extends StatelessWidget {
  const CircleImage(this.image, {Key? key, this.margin}) : super(key: key);

  factory CircleImage.asset(
    String imagePath, {
    EdgeInsets? margin,
  }) =>
      CircleImage(
        AssetImage(imagePath),
        margin: margin,
      );

  factory CircleImage.network(
    String imageUrl, {
    EdgeInsets? margin,
    double? size,
  }) =>
      CircleImage(
        NetworkImage(imageUrl),
        margin: margin,
      );

  final ImageProvider image;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(image: image),
      ),
    );
  }
}
