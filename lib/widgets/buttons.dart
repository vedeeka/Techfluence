import 'package:flutter/material.dart';
import 'package:techfluence/data/themes.dart';

class MyButton extends StatefulWidget {
  final VoidCallback f;
  final Color color;
  final String text;
  const MyButton({super.key,required this.f, this.color = lightGrey,required this.text});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.f();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(color: widget.color,borderRadius: BorderRadius.circular(8),),child: Text(widget.text),
      ),
    );
  }
}