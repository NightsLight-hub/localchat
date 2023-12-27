import 'package:flutter/material.dart';

/// A [DropdownButton] with a custom theme.
/// Currently, there is no easy way to apply color and border radius to all [DropdownButton].
class CustomDropdownButton<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool expanded;

  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).inputDecorationTheme.fillColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: DropdownButton<T>(
        value: value,
        isExpanded: expanded,
        underline: Container(),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
