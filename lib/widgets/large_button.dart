import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;

  const LargeButton({Key key, @required this.text, @required this.onPressed, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)
              ),
              primary: color
          ),
        )
    );
  }
}
