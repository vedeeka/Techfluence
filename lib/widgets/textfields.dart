import 'package:flutter/material.dart';
import 'package:techfluence/data/themes.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  final Function(String)? onEnter;
  final TextEditingController c;
  final double radius;
  final Color color;
  final String hint;
  final Widget? prefix, suffix;
  final int lineNo;
  bool visible;
  MyTextField(
      {super.key,
      required this.c,
      this.radius = 8,
      this.color = lightGrey,
      required this.hint,
      this.prefix,
      this.suffix,
      this.visible = true,
      this.lineNo = 1,
      this.onEnter});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: widget.lineNo,
      maxLines: widget.lineNo,
      obscureText: !widget.visible,
      controller: widget.c,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
        filled: true,
        fillColor: widget.color,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
      onSubmitted: (value) {
        if (widget.onEnter != null) {
          widget.onEnter!(value);
        }
      },
    );
  }
}
