import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  String upperText = "";
  String hintText = "";

  TextEditingController controller;

  bool obscureText;

  CustomTextField ({this.obscureText = false, this.upperText, this.controller, this.hintText}) {
    if (this.controller == null) {
      this.controller = TextEditingController();
    }
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.upperText,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
          ),
          Container(
            //height: 100,
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              style: TextStyle(
                  fontSize: 27
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText
              ),
            ),
          )
        ],
      ),
    );
  }
}
