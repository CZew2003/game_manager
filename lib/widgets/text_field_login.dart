import 'package:flutter/material.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hideText,
  });

  final TextEditingController controller;
  final String hintText;
  final bool hideText;

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: TextField(
        obscureText: !widget.hideText ? widget.hideText : hideText,
        controller: widget.controller,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.5),
          ),
          suffixIcon: !widget.hideText
              ? null
              : IconButton(
                  style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
                  ),
                  onPressed: () {
                    setState(() {
                      hideText = !hideText;
                    });
                  },
                  icon: Icon(
                    hideText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
        ),
      ),
    );
  }
}
