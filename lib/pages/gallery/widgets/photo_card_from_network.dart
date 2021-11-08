import 'package:flutter/widgets.dart';

class PhotoCardFromNetwork extends StatelessWidget {
  const PhotoCardFromNetwork(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  static final BorderRadius _borderRadius = BorderRadius.circular(16);
  static const EdgeInsets _padding = EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: _borderRadius,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.12),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: _padding,
          child: ClipRRect(
            borderRadius: _borderRadius,
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
