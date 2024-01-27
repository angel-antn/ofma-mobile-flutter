import 'package:flutter/material.dart';

class PaymentRadioListTile extends StatelessWidget {
  const PaymentRadioListTile({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.index,
    required this.title,
    this.subtitle,
  });

  final int? selectedValue;
  final Function(int) onChanged;
  final int index;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        value: index,
        groupValue: selectedValue,
        onChanged: (value) => onChanged(value!));
  }
}
