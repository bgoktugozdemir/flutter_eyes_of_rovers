import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDropdownButton extends StatefulWidget {
  const AdaptiveDropdownButton({
    Key? key,
    required this.onSelectedItemChanged,
    required this.items,
    required this.value,
    required this.child,
    this.defaultValue,
  }) : super(key: key);

  final void Function(int?) onSelectedItemChanged;
  final List<String> items;
  final String? value;
  final Widget child;
  final String? defaultValue;

  @override
  State<AdaptiveDropdownButton> createState() => _AdaptiveDropdownButtonState();
}

class _AdaptiveDropdownButtonState extends State<AdaptiveDropdownButton> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue != null) {
      widget.items.insert(0, widget.defaultValue!);
    }

    if (Platform.isIOS) {
      const TextStyle textStyle = TextStyle(color: CupertinoColors.activeBlue);
      return CupertinoButton(
        child: widget.child,
        onPressed: () async => showCupertinoModalPopup(
          context: context,
          builder: (context) => ColoredBox(
            color: const Color(0xFFFFFFFF),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: const Text('Cancel', style: textStyle),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CupertinoButton(
                        child: const Text('OK', style: textStyle),
                        onPressed: () {
                          widget.onSelectedItemChanged(selectedIndex);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 32,
                      onSelectedItemChanged: setIndex,
                      children: widget.items.map((item) => Text(item)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    final items = widget.items
        .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: widget.value ?? widget.defaultValue,
        items: items,
        onChanged: (selectedItem) {
          if (selectedItem == null) {
            // If user does not select an item
            selectedIndex = null;
          } else {
            final index = widget.items.indexOf(selectedItem);
            setIndex(index);
          }
          widget.onSelectedItemChanged(selectedIndex);
        },
        underline: const SizedBox.shrink(),
      ),
    );
  }

  void setIndex(int index) {
    if (widget.defaultValue != null) {
      if (index == 0) {
        // if a default value (ALL) is set and user selected the default value (ALL)
        selectedIndex = null;
      } else {
        // if a default value (ALL) is set and user selected the other values (except ALL)
        selectedIndex = index - 1;
      }
    } else {
      // if a default value (ALL) is not set
      selectedIndex = index;
    }
  }
}
