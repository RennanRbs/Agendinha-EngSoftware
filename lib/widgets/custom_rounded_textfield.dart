import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRoundedTextField extends StatefulWidget {

  String upperText = "";

  TextEditingController controller;

  bool obscureText;

  CustomRoundedTextField ({this.obscureText = false, this.upperText, this.controller}) {
    if (this.controller == null) {
      this.controller = TextEditingController();
    }
  }

  @override
  _CustomRoundedTextFieldState createState() => _CustomRoundedTextFieldState();
}

class _CustomRoundedTextFieldState extends State<CustomRoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.upperText,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
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
                  fontSize: 21
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(100.0),
                    )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
