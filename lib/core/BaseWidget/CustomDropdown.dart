import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String label;
  final void Function(T?)? onChanged;
  final String Function(T)? itemLabelBuilder;
  final Icon? iconPrefix;
  final Color colorText;

  const CustomDropdown(
      {super.key,
      required this.value,
      required this.items,
      required this.label,
      required this.onChanged,
      required this.itemLabelBuilder,
      this.colorText = UtilColors.primaryKeyColor,
      this.iconPrefix});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 12.sp, color: colorText),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        filled: true,
        fillColor: Colors.grey[100],
        prefixIcon: iconPrefix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorText, width: 2),
        ),
      ),
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            itemLabelBuilder!(value),
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
