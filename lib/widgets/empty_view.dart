import 'package:flutter/widgets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    required this.icon,
    required this.message,
    this.style,
  }) : super(key: key);

  final IconData icon;
  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: MediaQuery.of(context).size.width * 0.24,
          ),
          const SizedBox(height: 12),
          Text(message, style: style),
        ],
      ),
    );
  }
}
