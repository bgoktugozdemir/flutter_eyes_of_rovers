import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';

class Counter extends StatefulWidget {
  const Counter({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final int value;
  final void Function(int)? onChanged;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int value;
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconButton(
          icon: const AdaptiveIcon(
            cupertinoIcon: CupertinoIcons.minus,
            materialIcon: Icons.remove,
          ),
          onPressed: () {
            setState(() => value--);
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
        const SizedBox(width: 8),
        Text('$value'),
        const SizedBox(width: 8),
        _IconButton(
          icon: const AdaptiveIcon(
            cupertinoIcon: CupertinoIcons.plus,
            materialIcon: Icons.add,
          ),
          onPressed: () {
            setState(() => value++);
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: icon,
    );
  }
}
