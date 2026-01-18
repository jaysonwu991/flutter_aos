import 'package:flutter/material.dart';
import 'package:flutter_aos/constants/area_codes.dart';

/// Reusable area code picker widget
/// Used in login and registration forms to select country/region code
class AreaCodePicker extends StatelessWidget {
  const AreaCodePicker({
    required this.selectedAreaCode,
    required this.onChanged,
    super.key,
  });

  final String selectedAreaCode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 4),
      child: DropdownButton<String>(
        value: selectedAreaCode,
        isDense: false,
        underline: const SizedBox.shrink(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: AreaCodes.codes.map<DropdownMenuItem<String>>((String code) {
          return DropdownMenuItem<String>(
            value: code,
            child: Text(code),
          );
        }).toList(),
      ),
    );
  }
}
