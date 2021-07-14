import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactGroupList extends StatefulWidget {

  RxList<String> observableList;

  ContactGroupList({Key key, @required this.observableList}) : super(key: key);

  @override
  _ContactGroupListState createState() => _ContactGroupListState();
}

class _ContactGroupListState extends State<ContactGroupList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: widget.observableList.length + 1,
            itemBuilder: (_, index) {
              if (index == widget.observableList.length) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      TextEditingController alertTextController = TextEditingController();
                      Get.dialog(AlertDialog(
                        title: Text("Adicionar grupo de contato"),
                        content: TextField(
                          controller: alertTextController,
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            widget.observableList.add(alertTextController.text);
                            Get.back();
                          }, child: Text("Adicionar")),
                          TextButton(onPressed: () {
                            Get.back();
                          }, child: Text("Cancelar"))
                        ],
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Adicionar grupo",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                );
              } else {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                      child: Text(widget.observableList[index],
                        style: GoogleFonts.montserrat(
                          fontSize: 14
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: (){
                        widget.observableList.removeAt(index);
                      },
                      child: Icon(Icons.remove),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        primary: Colors.orange
                      ),
                    )
                  ],
                );
              }
            },
            separatorBuilder: (_, index) {
              return Divider(thickness: 2,);
            }
          );
        },
      ),
    );
  }
}
