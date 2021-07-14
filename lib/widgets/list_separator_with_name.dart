import 'package:flutter/material.dart';

class ListSeparatorWithName extends StatelessWidget {

  final String title;

  ListSeparatorWithName({this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 1,
            color: Color(0xFFB7B7B7).withAlpha(75),
          ),
          Container(
            color: Color(0xFFEEEEEE),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 7, 0, 7),
                child: Text(title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Color(0xFFB7B7B7).withAlpha(75),
          ),
        ],
      ),
    );
  }
}
