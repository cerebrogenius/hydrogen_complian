import 'package:flutter/material.dart';
import 'package:hydrogen_complian/widgets/text_field_widget.dart';

class TextWithTitle extends StatelessWidget {
  final String title;
  final String labelText;
  final bool extendTextField;
  final TextEditingController controller;
  const TextWithTitle({super.key, required this.title, required this.labelText, required this.extendTextField, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.only(left:30.0, bottom: 5, top:10),
          child: 
          Text(title, style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.blueAccent
          ),),
        ),
        MyTextField(
          controller:controller ,
          extendTextFiled: extendTextField,
          labelText: labelText, obscureText: false)
      ],
    );
  }
}