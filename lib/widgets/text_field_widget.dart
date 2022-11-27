import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hydrogen_complian/providers/paste_provider.dart';
import 'package:provider/provider.dart';

class MyTextField extends StatefulWidget {
  final bool? paste;
  final String? hintText;
  final String labelText;
  final bool obscureText;
  final bool extendTextFiled;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.extendTextFiled,
    required this.controller,
    this.paste,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.blue)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  maxLines: widget.extendTextFiled ? null : 1,
                  textAlign: TextAlign.center,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                  ),
                ),
              ),
              widget.paste == true
                  ? IconButton(
                      onPressed: () async {
                        final value = await FlutterClipboard.paste();
                        setState(() {
                          widget.controller.text = value;
                        });
                        Provider.of<PasteProvider>(context, listen: false).changePaste();
                      },
                      icon: const Icon(Icons.paste))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
