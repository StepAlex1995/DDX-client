import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../text/text.dart';

class DropdownButtonApp extends StatelessWidget {
  final String selectedValue;
  final Function(String? newV)? setState;

  const DropdownButtonApp(
      {super.key, required this.selectedValue, this.setState});

  @override
  Widget build(BuildContext context) {
    return Column(
     /* children: [
        Material(
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(20),
                dropdownColor: Colors.blueAccent,
                // value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: AppTxt.dropdownItems))
      ],*/
    );
  }
}
