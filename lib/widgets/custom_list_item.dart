import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {

  final name;
  final email;
  Function onHold = () {};
  Function onClick = () {};

  CustomListItem({Key key, @required this.name, @required this.email, this.onHold, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onLongPress: onHold,
          onTap: onClick,
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 13,),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Nome: " + name,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("E-mail: " + email,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 0,
                      color: Colors.black.withAlpha(35)
                  )
                ],
                border: Border.all(
                    color: Colors.grey[500],
                    width: 0.2
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            height: 80,
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
